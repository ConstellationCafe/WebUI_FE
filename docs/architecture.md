# WebUI_FE Architecture

> 상태: Active  
> 마지막 검토일: 2026-09-28  
> 상위 문서: [README](../README.md) · 관련: [기능별 구현 노트](features.md), [디자인 시스템](design-system.md)

## 1. 시스템 구성

```text
브라우저 (Flutter Web, nginx :1104)
   ├── HTTP / SSE (HttpOnly 쿠키) ──► WebUI_BE (BACKEND_URI)
   ├── HTTP JSON envelope ──────────► 빗자루 봇 router (ROUTE_URI)
   └── redirect ────────────────────► Discord OAuth (CLIENT_ID, REDIRECT_URI)
```

- 대부분의 기능은 [WebUI_BE](https://github.com/ConstellationCafe/WebUI_BE)를 호출합니다.
- 친선전(Shadowverse), Academy 학생·강사 현황 수정, 프로필 멤버십 카드 생성·UID·채팅방 변경은 `core/network/discordBot`의 `APITranslator` → `SocketClient`로 빗자루 봇([ModularDiscordBot](https://github.com/ConstellationCafe/ModularDiscordBot)) router에 `SocketModel` envelope(`src`, `dst`, `payload.sub`, `payload.target_func`, `payload.args`)을 HTTP POST합니다(timeout 10초). 이름과 달리 WebSocket이 아닙니다.

## 2. 폴더 구조

```text
lib/
├── main.dart               # ProviderScope, MaterialApp.router, PathUrlStrategy
├── router/                 # GoRouter(@riverpod), 로그인·채팅방 선택 redirect 가드
├── core/
│   ├── constants/          # theme(CustomTheme), 색·padding·size·shadow token, 화면 폭 breakpoint
│   ├── keys/               # 전역 ScaffoldMessenger key
│   ├── network/            # dioProvider, AuthInterceptor, ErrorInterceptor, 봇 router client
│   └── utils/              # 날짜 formatter
├── shared/                 # 공용 DTO(ApiResponse 등)·domain(사용자·권한·pagination)·DB 편집기·공용 widget
└── feature/
    ├── auth/               # 로그인, 로그인 상태 확인
    ├── guild_select/       # 채팅방 선택
    ├── home/               # 공통 frame(앱바, drawer, 메뉴, 프로필), 홈 콘텐츠
    ├── profile/            # 프로필, 본인 포인트 내역
    ├── notification/       # 알림 종·패널, 관리자 알림 발행
    └── modules/
        ├── academy/        # ★ 기준 feature 구조
        ├── chatbot/        # content·learning·menu·music
        ├── erp/            # point, penalty (관리자)
        └── shadowverse/    # friendly_match
```

## 3. feature 구조 기준

새 feature는 `feature/modules/academy`(또는 같은 구조인 `erp/*`, `notification`)를 따르고, 다른 구조가 필요하면 PR에 이유를 적습니다.

| 폴더 | 책임 |
|---|---|
| `data/api` | HTTP 호출(Dio) |
| `data/dto/request`, `data/dto/response` | Backend 계약 DTO(`json_serializable`). 임의의 JSON `Map`으로 대신하지 않음 |
| `data/repository` | DTO ↔ domain model 변환 |
| `domain/model`, `domain/type` | 업무 model, enum |
| `state/` | `@freezed` 불변 UI 상태. 여러 widget·notifier가 공유하는 page state도 여기에 둠 |
| `notifier/` | `@riverpod` code generation notifier |
| `pages/` | 화면 조합과 navigation 경계 |
| `widgets/` | 재사용 UI (widget lifecycle에만 속한 private state는 여기 가능) |
| `routes/`, `constants/` | 경로, feature 전용 문자열·token |

`chatbot`, `profile`, `shadowverse`, `auth`, `guild_select`는 이전 구조(`repository/`, `domain/entity`, `api/` 등)를 유지하고 있습니다. 해당 feature를 크게 고칠 때 기준 구조로 옮깁니다.

## 4. 상태 관리 규칙 (Riverpod)

- notifier는 `@riverpod` code generation을 씁니다. 같은 feature 안에서 수동 provider와 섞지 않습니다.
- build에 필요한 값은 `ref.watch`, event handler에서는 `ref.read`, 상태 변화에 따른 side effect(SnackBar, navigation)는 `ref.listen`으로 처리합니다.
- 단순 비동기 로딩은 `AsyncValue`, form·pagination·submitting처럼 상태가 여럿이면 `@freezed` state model을 씁니다. 모든 상태를 `isLoading` 하나로 표현하지 않습니다.
- auto-dispose가 기본이며, 화면 종료 뒤 늦게 끝난 요청은 상태를 바꾸지 않습니다.
- `BuildContext`는 service·repository로 넘기지 않고, 비동기 작업 뒤에는 `mounted`를 확인합니다.

## 5. 라우팅과 가드 (`router/router_provider.dart`)

| 상태 | 이동 |
|---|---|
| 로그인 확인 중 + `/home` | `/loading?guild_id=` |
| 미로그인 | `/login` |
| 로그인 후 `/` 또는 `/login` | `/select` |
| `/home` 진입 | 채팅방 선택을 마친 토큰(`roomSelected`)이고 `guild_id`가 사용자 길드 목록에 있을 때만 허용, 아니면 `/select` |
| 예외 발생 | `/` |

- `/login`, `/select`, `/loading`은 `Scaffold`를 쓰는 독립 화면이고, 나머지는 `ShellRoute`(`HomeFrame`) 아래의 widget입니다.
- URL은 `PathUrlStrategy`(해시 없음)라 nginx의 SPA fallback이 필요합니다([deploy](deploy.md)).

## 6. 네트워크

- `dioProvider`: `AuthInterceptor` → `ErrorInterceptor` 순서로 등록합니다.
- `AuthInterceptor`: 401일 때만 `/auth/refresh` 후 원 요청을 1회 재시도하고, 동시 요청은 refresh 하나를 공유합니다. 403(채팅방 미등록·비회원)과 404(권한 없음)는 refresh로 해결되지 않으므로 재시도하지 않습니다.
- `ErrorInterceptor`: 오류를 전역 SnackBar로 보여줍니다. 화면이 직접 오류를 표시하는 요청은 `ErrorInterceptor.silentErrorKey`로 끕니다.
- 인증은 백엔드의 HttpOnly 쿠키로만 하며, 토큰을 JS·URL·local storage에 두지 않습니다.
- timeout: 벌점 API receive 15초, 봇 router 10초. 그 밖의 Dio 요청은 기본값이며 전역 timeout 정책은 미정입니다.
- 시간: 서버와는 UTC로 주고받고 화면에서 브라우저 현지 시각으로 표시합니다.

## 7. platform 경계

- 지원 platform은 Web뿐입니다.
- 브라우저 API는 `package:web`과 conditional import로 격리합니다(예: `feature/notification/data/realtime/`).
- 예외: `feature/auth/api/discord_login.dart`가 `dart:html`을 직접 씁니다. 가이드 위반이며 이전이 필요합니다.
