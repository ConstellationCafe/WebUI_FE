# WebUI_FE Architecture

> 상태: Active  
> 마지막 검토일: 2026-09-29  
> 상위 문서: [README](../README.md) · 관련: [기능별 구현 노트](features.md), [디자인 시스템](design-system.md)

## 1. 시스템 구성

```text
브라우저 (Flutter Web, nginx :1104)
   ├── HTTP / SSE (HttpOnly 쿠키) ──► WebUI_BE (BACKEND_URI)
   ├── HTTP JSON envelope ──────────► 빗자루 봇 router (ROUTE_URI)
   └── redirect ────────────────────► Discord OAuth (CLIENT_ID, REDIRECT_URI)
```

- 대부분의 기능은 [WebUI_BE](https://github.com/ConstellationCafe/WebUI_BE)를 호출합니다.
- 친선전(Shadowverse), Academy 학생·강사 현황 수정, 프로필 멤버십 카드 생성·UID·채팅방 변경은 `core/network/discord_bot`의 `APITranslator` → `SocketClient`로 빗자루 봇([ModularDiscordBot](https://github.com/ConstellationCafe/ModularDiscordBot)) router에 `SocketModel` envelope(`src`, `dst`, `payload.sub`, `payload.target_func`, `payload.args`)을 HTTP POST합니다(timeout 10초). 이름과 달리 WebSocket이 아닙니다.

## 2. 폴더 구조

```text
lib/
├── main.dart               # ProviderScope, MaterialApp.router, PathUrlStrategy
├── router/                 # GoRouter(@riverpod), 로그인·채팅방 선택 redirect 가드
├── core/
│   ├── constants/          # theme(CustomTheme), 색·padding·size·shadow token, 화면 폭 breakpoint
│   ├── keys/               # 전역 ScaffoldMessenger key
│   ├── network/            # dioProvider, interceptors/, 봇 router client(discord_bot/), timeout·오류 문구
│   └── utils/              # 날짜 formatter
├── shared/                 # 공용 DTO(ApiResponse, RepositoryPageResponse, BotCommandResponse)·domain·DB 편집기(notifier/state/widgets)·공용 widget
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

- `auth`, `guild_select`, `profile`, `shadowverse`, `chatbot`도 `data/api`·`data/dto`·`data/repository`로 옮겼습니다.
- `chatbot`과 `profile`의 포인트 내역은 공용 DB 편집기용 `domain/entity`(`Entity`)를 씁니다. 컬럼 구성이 서버 metadata로 정해지므로, 응답 envelope은 `RepositoryPageResponse` DTO가 해석하고 컬럼 metadata만 `Map`으로 둡니다.
- 빗자루 봇 router 응답은 `BotCommandResponse`로 envelope을 해석하고, 명령별 결과는 각 feature DTO(`MembershipCardResponse`, `FriendlyMatchRequest` 등)가 다룹니다.
- 파일·폴더 이름은 `lower_case_with_underscores`, 화면 폴더는 `pages/`로 통일합니다.

## 4. 상태 관리 규칙 (Riverpod)

- notifier는 `@riverpod` code generation을 씁니다. 같은 feature 안에서 수동 provider와 섞지 않습니다. (API·repository 인스턴스를 만드는 `Provider`는 상태가 없는 의존성 주입용이라 예외입니다.)
- 공용 DB 편집기도 `dbEditorProvider(repository)`(`shared/notifier/db_editor`)가 상태를 소유합니다. 표 데이터(`DBModel`)는 셀 입력마다 전체를 다시 그리지 않도록 가변 모델로 두고, 목록·선택·편집 모드가 바뀔 때 `revision`을 올려 알립니다.
- `keepAlive`는 화면을 오가도 유지해야 하는 상태(로그인 사용자, 선택한 채팅방, 채팅방 목록, 아카데미 권한, 회원증)에만 쓰고 이유를 주석으로 남깁니다. 브라우저 새로고침은 앱을 다시 시작하므로 keepAlive로 유지되지 않습니다.
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
- timeout (`core/network/network_timeouts.dart`)

  | 대상 | 값 | 초과 시 |
  |---|---|---|
  | Dio 전체(`dioProvider`) | 연결 10초, 응답 30초 | `ErrorInterceptor`가 시간 초과 SnackBar를 띄우고 화면은 오류 상태를 보여줌 |
  | 벌점 API | 응답 15초(요청별) | 부여·취소 다이얼로그가 "결과 확인 불가"로 전환, 같은 요청 ID로 재시도 |
  | 인증 check·refresh·logout(`http`) | 전체 30초 | check는 로그아웃 상태, refresh는 실패, logout은 무시하고 로컬 상태를 지움 |
  | 빗자루 봇 router | 전체 10초 | `{'status_code': false, 'message': ...}`로 바꿔 화면이 실패 안내 |

  근거: 서버 heartbeat(25초)와 일반 조회 응답 시간을 고려한 초기값입니다. SLO가 정해지면 다시 검토합니다.
- HTTP 요청의 자동 재시도는 `AuthInterceptor`의 401 → refresh 1회뿐입니다. 입·출금·벌점·알림 발행처럼 부작용이 있는 요청은 자동 재시도하지 않습니다. 조회용 provider의 build 실패는 Riverpod 3 기본 재시도 정책을 따릅니다.
- 사용자에게는 예외 원문 대신 고정 안내 문구를 보여줍니다(`NetworkStrings`, 각 feature `*_strings.dart`).
- 시간: 서버와는 UTC로 주고받고 화면에서 브라우저 현지 시각으로 표시합니다. 현재 시각이 결과에 영향을 주는 widget(벌점 부여, 수업 날짜·시간 선택, 알림 패널)은 `clock`을 주입받습니다.

## 7. platform 경계

- 지원 platform은 Web뿐입니다.
- 브라우저 API는 `package:web`과 conditional import로 격리합니다(예: `feature/notification/data/realtime/`, `feature/auth/data/api/browser/`). `dart:html`은 쓰지 않습니다.
