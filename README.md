# 🌟 빗자루 WebUI Frontend

> 상태: Active  
> 적용 범위: `ConstellationCafe/WebUI_FE` Flutter Web 클라이언트 (`develope` 기준)  
> 문서 담당자: 미정 — 프로젝트 책임자가 지정 필요  
> 마지막 검토일: 2026-09-28 (`develope` `1222d0b`, PR #69까지 반영)

## 1. 프로젝트 개요

[빗자루](https://github.com/ConstellationCafe/DiscordBot)는 섀버 별자리 Cafe에서 개발·운영하는 Discord 채팅 봇으로, 섀도우버스 편의 기능과 채팅방 운영 도구를 제공합니다. 이 저장소는 명령어 기반 봇 조작의 한계를 넘기 위한 WebUI이며, [WebUI_BE](https://github.com/ConstellationCafe/WebUI_BE)(Spring Boot)와 빗자루 봇 router를 호출합니다.

지원 범위: Flutter **Web** 빌드만 배포합니다(`flutter build web` → nginx). 다른 platform 폴더(android/ios 등)는 저장소에 없습니다.

### 주요 기능

| 영역 | 경로 | 대상 | 설명 |
|---|---|---|---|
| 로그인 | `/login` | 전체 | Discord OAuth 2.0 로그인 |
| 채팅방 선택 | `/select` | 로그인 사용자 | 가입한 채팅방(길드) 선택. 선택한 방 기준으로 이후 API 권한 적용(ADR-0001) |
| 홈 | `/home?guild_id=` | 로그인 + 채팅방 선택 | 공통 frame(앱바·메뉴·알림 종·프로필) |
| 프로필 | `/profile`, `/point_log`, `/my-penalties` | 회원 | 멤버십 정보, 본인 포인트 내역, 본인 벌점 |
| 알림 | 헤더 종 아이콘 | 회원 | 공지·포인트 등 실시간 알림, 읽지 않은 알림 빨간 점 |
| ChatBot | `/content`, `/learning`, `/menu`, `/music` | 회원 | 추천 콘텐츠·학습 자료·메뉴·음악 DB 편집기 |
| Shadowverse | `/friendly_match` | 회원 | 친선전 게시판(빗자루 봇 router 경유) |
| Academy | `/academy/*` | Academy 권한 보유자 | 수업 기록 작성·조회, 학생·강사 현황 조회·수정 |
| ERP (관리자) | `/point`, `/penalties`, `/notification` | `ADMIN` | 포인트 입·출금, 벌점 부여·취소, 알림 발행 |

메뉴는 권한에 따라 표시됩니다. Academy 메뉴는 Academy 권한 조회가 끝난 뒤, ERP 메뉴는 `UserRole.ADMIN`일 때만 보입니다. 권한 최종 판단은 서버가 합니다.

## 2. 기술 stack과 개발 환경

| 항목 | 요구사항 | 근거 |
|---|---|---|
| Flutter | 배포 이미지 3.41.2 고정, CI는 `stable` channel | `Dockerfile` `FLUTTER_VERSION`, `CI.yml` |
| Dart SDK | `>=3.9.0 <4.0.0` | `pubspec.yaml` |
| 브라우저 | Chrome (로컬 실행·`flutter test --platform chrome`) | CI |
| Docker / Docker Compose | 컨테이너 빌드·배포 시 | `Dockerfile`, `docker-compose.yml` |

주요 라이브러리

| 분류 | 패키지 |
|---|---|
| 상태 관리 | `flutter_riverpod` ^3.3.1, `riverpod_annotation` ^4.0.2, `riverpod_generator` ^4.0.3 |
| 불변 모델·직렬화 | `freezed` ^3.2.5, `freezed_annotation` ^3.1.0, `json_serializable` ^6.13.0, `build_runner` ^2.13.1 |
| 라우팅 | `go_router` ^16.0.0 (`PathUrlStrategy`) |
| 네트워크 | `dio` ^5.4.0, `dio_cookie_manager`, `cookie_jar`, `http` ^1.2.2 |
| Web API | `web` ^1.1.1 (실시간 알림 `EventSource`) |
| UI | `flutter_svg`, `image_picker`, `url_launcher`, `intl` |

정확한 버전은 `pubspec.lock`이 기준입니다.

## 3. 설치·실행·검증

```sh
# 의존성 설치 (pubspec.lock 사용)
flutter pub get

# 로컬 실행: 설정은 --dart-define으로 주입 (4장)
flutter run -d chrome \
  --dart-define=CLIENT_ID=<discord_client_id> \
  --dart-define=REDIRECT_URI=<oauth_redirect_uri> \
  --dart-define=ROUTE_URI=<bot_router_uri> \
  --dart-define=BACKEND_URI=<backend_uri>

# 생성 코드 재생성 (@riverpod, @freezed, @JsonSerializable 변경 시)
dart run build_runner build --delete-conflicting-outputs

# CI와 같은 검증
dart format --output=none --set-exit-if-changed .
flutter analyze --no-fatal-warnings --no-fatal-infos
flutter test --platform chrome
flutter build web
```

성공 기준

- `dart format`이 변경 없이 종료하고, `flutter analyze`에 새 error가 없습니다(기존 warning/info는 CI에서 차단하지 않지만 변경한 파일에서는 제거합니다).
- `flutter test --platform chrome`이 모두 통과하고 `flutter build web`이 `build/web`을 생성합니다.
- 로컬 실행 시 `/login`이 열리고, Discord 로그인 후 `/select`로 이동합니다.

## 4. 설정과 환경

설정은 빌드 시 `--dart-define`으로 주입하며 `String.fromEnvironment`로 읽습니다. `.env` 파일은 사용하지 않고(`.gitignore` 대상), 값은 커밋하지 않습니다.

| 변수 | 필수 | 용도 | 안전한 예시 형식 |
|---|:---:|---|---|
| `CLIENT_ID` | 예 | Discord OAuth client ID | Discord 발급 값 |
| `REDIRECT_URI` | 예 | Discord OAuth redirect URI (백엔드 `/auth/discord_login`) | `https://example.test/auth/discord_login` |
| `BACKEND_URI` | 예 | WebUI_BE 기본 URI | `https://example.test` |
| `ROUTE_URI` | 예 | 빗자루 봇 router URI (친선전·일부 Academy·멤버십 조회) | `https://example.test/route` |

- Flutter Web 번들은 누구나 내려받을 수 있으므로 여기에는 **공개해도 되는 값만** 넣습니다. 비밀값·서버 권한 판단은 client에 두지 않습니다.
- production 값은 GitHub Actions secrets(`CLIENT_ID`, `REDIRECT_URI`, `ROUTE_URI`, `BACKEND_URI`)로 CD가 Docker build arg에 전달합니다.
- 인증 토큰은 백엔드가 내려주는 HttpOnly 쿠키로만 다루며, JS·URL·local storage에 넣지 않습니다.

## 5. 구조와 Architecture

```text
lib/
├── main.dart               # ProviderScope, MaterialApp.router, PathUrlStrategy
├── router/                 # GoRouter(@riverpod), 로그인·채팅방 선택 redirect 가드
├── core/
│   ├── constants/          # theme(CustomTheme), 색·padding·size·shadow token, 화면 폭 breakpoint
│   ├── keys/               # 전역 ScaffoldMessenger key
│   ├── network/            # dioProvider, AuthInterceptor(401 → refresh 1회 재시도), ErrorInterceptor(전역 SnackBar), 봇 router client
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

**feature 구조 기준** (`feature/modules/academy`, `erp/*`, `notification`)

| 폴더 | 책임 |
|---|---|
| `data/api` | HTTP 호출(Dio) |
| `data/dto/request`, `data/dto/response` | Backend 계약 DTO(`json_serializable`) |
| `data/repository` | DTO ↔ domain model 변환 |
| `domain/model`, `domain/type` | 업무 model, enum |
| `state/` | `@freezed` 불변 UI 상태 (공유 page state도 여기에 둠) |
| `notifier/` | `@riverpod` code generation notifier |
| `pages/` | 화면 조합과 navigation 경계 |
| `widgets/` | 재사용 UI |
| `routes/`, `constants/` | 경로, feature 전용 문자열·token |

새 feature는 이 구조를 따르고, 다른 구조가 필요하면 PR에 이유를 적습니다. `chatbot`, `profile`, `shadowverse`, `auth`는 이전 구조(`repository/`, `domain/entity` 등)를 유지하고 있습니다.

**요청 흐름**: page/widget → notifier(`ref.watch`로 구독, event에서 `ref.read`) → repository → API(Dio + interceptor) → WebUI_BE. side effect(SnackBar, navigation)는 `ref.listen`으로 처리합니다.

**라우팅 가드** (`router_provider.dart`): 로그인 확인 중에는 `/loading`, 미로그인은 `/login`, 로그인 후 `/` 또는 `/login`은 `/select`, `/home`은 채팅방이 선택되었고 `guild_id`가 사용자 길드 목록에 있을 때만 진입합니다. `/login`, `/select`, `/loading`을 제외한 화면은 `ShellRoute`(`HomeFrame`) 아래에 둡니다.

## 6. API 연동

- **명세 기준 위치**: Notion `섀버 별자리 Cafe 개발 본부 / 명세서 / API 명세서`의 기능별 페이지(공통 규격, Auth, Academy, ChatBot, Membership, Shadowverse, Penalty, Notification). DTO는 이 명세와 WebUI_BE 구현에 맞춥니다.
- 응답은 공통 `ApiResponse { success, response, error }`를 `shared/data/dto/response/backend`에서 해석합니다.
- 인증: 쿠키 기반. `AuthInterceptor`가 401일 때만 `/auth/refresh` 후 1회 재시도하고, 동시 요청은 refresh를 공유합니다. 403(채팅방 미등록·비회원)과 404(권한 없음)는 재시도하지 않습니다.
- timeout: 벌점 API receive 15초, 봇 router 요청 10초. 그 밖의 Dio 요청은 기본값이며 전역 timeout 정책은 미정입니다.
- 중복 제출: 벌점 부여·알림 발행은 요청 ID를 한 번 만들고 재전송 시 재사용해 서버 idempotency와 맞춥니다. 제출 중 버튼은 비활성화합니다.
- 시간: 서버와는 UTC로 교환하고 화면에서 브라우저 현지 시각으로 표시합니다. 시간대 없이 오는 UTC 일시는 DTO 경계에서 UTC로 해석합니다.

## 7. UI·디자인·접근성

- **theme**: `core/constants/theme_data.dart`의 `CustomTheme`. Primary `#FFFFFF`, Secondary `#000D27`, Tertiary `#1A1A1E`, Surface `#F5F6F7`, Error `#D32F2F`.
- **design token**: 공통 값은 `core/constants`(`const_padding`, `const_size`, `const_shadow`, `const_color`), feature 전용 값은 각 feature의 `constants/`에 둡니다. dialog 버튼은 app theme의 버튼 convention을 따르고 대비를 theme에서 확인합니다.
- **반응형 breakpoint** (`ScreenWidth`): mobile `< 500px`, tablet `< 900px`, laptop `< 1350px`, wide `≥ 1350px`. laptop 이상은 desktop layout입니다.
- **상태 표현**: 비동기 화면은 loading·empty·error·success를 구분하고, 빈 설명은 `등록된 설명이 없습니다.`처럼 안내 문구로 표시합니다.
- **접근성**: 포인트·벌점·알림 widget test에서 작은 화면, 큰 글자(text scaling), 버튼 대비, semantics를 확인합니다.
- **국제화**: 한국어 단일 locale입니다. feature 전용 문자열은 `constants/*_strings.dart`에 모으고 있으나, localization resource(ARB)와 fallback locale은 아직 도입하지 않았습니다.
- **폰트**: Noto Sans KR(`assets/fonts/NotoSansKR`)을 의도하지만 현재 `pubspec.yaml`에 올바르게 등록되지 않았습니다(12장).

## 8. 기능별 참고사항

### ERP 포인트 관리 (`lib/feature/modules/erp/point/`)
- `notifier/`는 `@riverpod` 생성 provider, `state/`는 `@freezed` 불변 UI 상태입니다. 화면 종료 시 provider가 해제되며, 늦게 완료된 요청은 상태를 수정하지 않습니다.
- 관리자 API는 `/api/admin/points/**`(ADR-0002)를 사용합니다. 검색 입력과 제출한 검색어는 UI 상태에서 구분하고, 다이얼로그 입력 controller는 해당 위젯 `State`에서 생성·해제합니다.

### ERP 벌점 관리 (`lib/feature/modules/erp/penalty/`)
- `/penalties`: 채널·대상별 벌점 이력, 조회 시점 기준 30일 누적 점수, 재적 회원 순위와 상세, 부여·취소. `/my-penalties`: 본인 벌점 이력.
- 서버가 JWT에서 현재 채팅방 `botId`를 꺼내므로 프런트는 `botId`나 `sk`를 보내지 않습니다. 대상은 숫자 Discord ID, 점수는 1점 고정, 발생 시각은 브라우저 현지 시각을 UTC로 변환합니다.
- 부여 다이얼로그는 요청 UUID를 한 번 생성하고 중복 제출을 막습니다.

### 알림 (`lib/feature/notification/`)
- 설계 근거: WebUI_BE ADR-0004(DB 저장 + Redis Pub/Sub + SSE).
- 헤더의 `NotificationBell`이 읽지 않은 알림이 있으면 빨간 점을 표시합니다. 패널을 열면 최신 알림까지 읽음 처리(`PUT /api/me/notifications/read-cursor`)하고, 새로 본 알림은 배경색과 "새 알림" 문구로 구분합니다.
- 실시간 수신은 `EventSource`(SSE, `GET /api/me/notifications/stream`)이며 인증은 HttpOnly 쿠키로 합니다(토큰을 URL에 넣지 않음). 브라우저 구현은 `data/realtime/`에서 conditional import로 격리했고(`package:web`), 그 외 platform은 REST 조회만 합니다.
- 연결 직후 `ready` 이벤트로 읽지 않은 개수를 다시 맞춥니다. 서버가 연결을 끝내면 읽지 않은 개수를 REST로 다시 받아 토큰 갱신을 거친 뒤 2초에서 시작해 최대 60초 간격(±20% jitter)으로 재연결합니다.
- 관리자는 `/notification`에서 채팅방 전체 또는 특정 회원에게 발행하고 이력을 봅니다. 링크는 `/`로 시작하는 앱 내부 경로만 허용합니다.
- 알림 API 호출은 화면이 오류를 직접 보여주므로 `ErrorInterceptor.silentErrorKey`로 전역 SnackBar를 끕니다.

### 공통 화면 규칙
- `/login`, `/select`, `/loading`은 `Scaffold`를 쓰는 독립 화면이고, 나머지는 `ShellRoute`의 하위 widget입니다.
- 카테고리는 Category + Search Bar + Tags 통합 검색을 지원하고, 사용자/관리자 메뉴를 분리합니다.

## 9. 테스트

| 범위 | 위치 | 검증 내용 |
|---|---|---|
| 공용 widget | `test/widget_test.dart` | loading·padding·SnackBar widget |
| 계약·유틸 | `test/api_test.dart` | 봇 router `SocketModel` 직렬화, `ApiResponse` 해석, 날짜 formatter |
| 포인트 | `test/feature/modules/erp/point/` | API 계약(직렬화·매핑), notifier 검색·페이지 이동·요청 경합·화면 종료·중복 제출, 작은 화면과 큰 글자, 버튼 대비, 빈 설명 |
| 벌점 | `test/feature/modules/erp/penalty/` | API 계약, 30일 누적 계산, notifier, widget |
| 알림 | `test/feature/notification/` | API 계약(경로·쿼리·UTC·요청 ID·실패 코드), 실시간 이벤트 변환·중복 제거, 패널 열기·읽음 처리, loading·error·empty, 발행 폼 검증과 재전송 멱등성 |

- repository는 `support/fake_*_repository.dart` fake로 대체하고 실제 network를 호출하지 않습니다.
- ChatBot, Academy, Shadowverse, 로그인·라우팅 가드는 자동 테스트가 아직 없습니다.

특정 feature만 실행하는 예시:

```sh
flutter test --platform chrome test/feature/notification
```

**CI gate** (`.github/workflows/CI.yml`, PR → `main`/`develope`, push → `develope`)

1. `flutter pub get` → `dart run build_runner build --delete-conflicting-outputs`
2. `dart format --output=none --set-exit-if-changed .`
3. `flutter analyze --no-fatal-warnings --no-fatal-infos`
4. `flutter test --platform chrome`
5. `flutter build web`
6. Docker image build (별도 job)

## 10. 생성 코드

- `*.g.dart`, `*.freezed.dart`는 **커밋합니다**. 직접 수정하지 않고, `@riverpod`·`@freezed`·`@JsonSerializable`을 바꾸면 `dart run build_runner build --delete-conflicting-outputs`로 재생성해 source와 같은 commit에 넣습니다.
- CI는 생성 후 벌점 feature 결과를 `penalty-generated-code` artifact로 올립니다.

## 11. Build·배포·운영

- artifact: `Dockerfile` multi-stage. Flutter 3.41.2로 `flutter build web --release`(build arg → `--dart-define`) 후 `nginx:1.25-alpine`에서 포트 **1104**로 서빙합니다. `nginx.conf`는 SPA fallback(`try_files ... /index.html`)을 둡니다.
- 배포(`.github/workflows/CD.yml`): `main` push → 빌드에 필요한 파일을 SCP로 원격 서버에 전송 → `docker compose -p webui-fe up -d --build`.
- 배포 순서: WebUI_BE API 계약이 바뀐 릴리스는 BE와 FE를 **같은 시점에** `main`으로 병합·배포하고 rollback도 함께 합니다(ADR-0002).
- rollback: 이전 검증 완료 commit으로 되돌려 다시 배포합니다.
- reverse proxy를 두면 `/api/me/notifications/stream` 응답 buffering을 끄고 read timeout을 30초 이상으로 둡니다(서버 heartbeat 25초).
- 로컬 Docker 절차: [배포 가이드](docs/deploy.md)
- 성능 budget, 운영 모니터링, 담당자는 아직 정하지 않았습니다.

## 12. 알려진 이슈와 후속 작업 (2026-09-28 기준)

- `pubspec.yaml`의 `fonts:`가 `flutter:` 아래가 아니고 경로도 `asset/`(실제는 `assets/`)여서 Noto Sans KR이 등록되지 않습니다.
- `feature/auth/api/discord_login.dart`가 `dart:html`을 직접 import합니다(flutter 가이드 위반, `package:web` 또는 conditional import로 이전 필요).
- CI는 Flutter `stable` channel, Docker는 3.41.2 고정이라 두 환경의 toolchain이 다를 수 있습니다.
- `flutter_dotenv`는 의존성에 있으나 사용하지 않습니다. `pubspec.yaml`의 `description`이 기본값입니다.
- `docs/deploy.md`의 Flutter 요구 버전(3.6.1+)은 현재 Dart `>=3.9.0` 요구와 맞지 않습니다.
- `sample/`의 스크린샷은 현재 화면과 다를 수 있습니다.

## 13. License

- 프로젝트 license: 미정 (지정 필요)
- 아이콘 출처: [copyrights_path.md](copyrights_path.md), [assets/icons/ReadMe.md](assets/icons/ReadMe.md) (Flaticon, Freepik, UXWing 등)
- 폰트: Noto Sans KR (SIL Open Font License 1.1)
