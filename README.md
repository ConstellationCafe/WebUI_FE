# 🌟 빗자루 WebUI Frontend

> 상태: Active  
> 적용 범위: `ConstellationCafe/WebUI_FE` Flutter Web 클라이언트 (`develope` 기준)  
> 문서 담당자: 미정 — 프로젝트 책임자가 지정 필요  
> 마지막 검토일: 2026-09-30

## 1. 프로젝트 개요

[빗자루](https://github.com/ConstellationCafe/ModularDiscordBot)는 섀버 별자리 Cafe에서 개발·운영하는 Discord 채팅 봇으로, 섀도우버스 편의 기능과 채팅방 운영 도구를 제공합니다. 이 저장소는 명령어 기반 봇 조작의 한계를 넘기 위한 WebUI이며, [WebUI_BE](https://github.com/ConstellationCafe/WebUI_BE)(Spring Boot)와 빗자루 봇 router를 호출합니다.

지원 범위: Flutter **Web** 빌드만 배포합니다(`flutter build web` → nginx). 다른 platform 폴더는 저장소에 없습니다.

### 주요 기능

| 영역 | 경로 | 대상 | 설명 |
|---|---|---|---|
| 로그인 | `/login` | 전체 | Discord OAuth 2.0 로그인 |
| 채팅방 선택 | `/select` | 로그인 사용자 | 가입한 채팅방(길드) 선택. 선택한 방 기준으로 이후 권한 적용 |
| 홈 | `/home?guild_id=` | 로그인 + 채팅방 선택 | 공통 frame(앱바·메뉴·알림 종·프로필) |
| 프로필 | `/profile`, `/point_log`, `/my-penalties` | 회원 | 멤버십 정보, 본인 포인트 내역, 본인 벌점 |
| 알림 | 헤더 종 아이콘 | 회원 | 공지·포인트 등 실시간 알림, 읽지 않은 알림 빨간 점 |
| ChatBot | `/content`, `/learning`, `/menu`, `/music` | 회원 | 추천 콘텐츠·학습 자료·메뉴·음악 DB 편집기 |
| Shadowverse | `/friendly_match` | 회원 | 친선전 게시판(빗자루 봇 router 경유) |
| Academy | `/academy/*` | Academy 권한 보유자 | 수업 기록 작성·조회, 학생·강사 현황 조회·수정 |
| ERP | `/point`, `/penalties`, `/notification` | 포인트·알림: `ADMIN` / 벌점: 운영 매니저·운영 본부원·`ADMIN` | 포인트 입·출금, 벌점 부여·취소, 알림 발행. 권한 있는 기능이 없으면 메뉴를 숨김 |

기능별 동작과 구현 규칙: [features](docs/features.md)

## 2. 문서 목록

| 문서 | 내용 |
|---|---|
| [docs/architecture.md](docs/architecture.md) | 시스템 구성, 폴더·feature 구조 기준, Riverpod 규칙, 라우팅 가드, 네트워크 |
| [docs/features.md](docs/features.md) | 기능별 구현 노트(로그인, 메뉴 권한, ChatBot, Academy, 포인트, 벌점, 알림, 프로필, 친선전) |
| [docs/design-system.md](docs/design-system.md) | theme, design token, breakpoint, 컴포넌트·접근성 규칙, 폰트, 국제화 |
| [docs/testing.md](docs/testing.md) | 테스트 실행·범위·작성 규칙, CI gate, 생성 코드 |
| [docs/deploy.md](docs/deploy.md) | 설정 변수, 로컬·Docker 실행, CI/CD, 배포 순서, reverse proxy |
| [copyrights_path.md](copyrights_path.md) | 아이콘 출처 |

API 계약 기준: Notion `섀버 별자리 Cafe 개발 본부 / 명세서 / API 명세서`, [WebUI_BE API 개요](https://github.com/ConstellationCafe/WebUI_BE/blob/develope/docs/api.md)

## 3. 기술 stack과 개발 환경

| 항목 | 요구사항 |
|---|---|
| Flutter | 3.41.2 고정 (Dockerfile·CI 동일) |
| Dart SDK | `>=3.9.0 <4.0.0` |
| 브라우저 | Chrome (로컬 실행·테스트) |
| Docker / Docker Compose | 컨테이너 빌드·배포 시 |

| 분류 | 패키지 |
|---|---|
| 상태 관리 | `flutter_riverpod` ^3.3.1, `riverpod_annotation` ^4.0.2, `riverpod_generator` ^4.0.3 |
| 불변 모델·직렬화 | `freezed_annotation` ^3.1.0 / dev: `freezed` ^3.2.5, `json_serializable` ^6.13.0, `build_runner` ^2.13.1 |
| 라우팅 | `go_router` ^16.0.0 (`PathUrlStrategy`) |
| 네트워크 | `dio` ^5.4.0 (연결 10초·응답 30초 timeout), `dio_cookie_manager`, `cookie_jar`, `http` ^1.2.2 |
| Web API | `web` ^1.1.1 (실시간 알림 `EventSource`, 로그인 페이지 이동), `flutter_web_plugins` (URL 전략) |
| UI | `flutter_svg`, `image_picker`, `url_launcher`, `intl` |

정확한 버전은 `pubspec.lock`이 기준이며, lockfile은 dependency 변경과 같은 commit에서 갱신합니다.

## 4. 빠른 시작과 검증

```sh
flutter pub get

# 로컬 실행 (변수 설명은 docs/deploy.md)
flutter run -d chrome \
  --dart-define=CLIENT_ID=<discord_client_id> \
  --dart-define=REDIRECT_URI=<oauth_redirect_uri> \
  --dart-define=ROUTE_URI=<bot_router_uri> \
  --dart-define=BACKEND_URI=<backend_uri>

# 생성 코드 재생성 (@riverpod, @freezed, @JsonSerializable 변경 시)
dart run build_runner build --delete-conflicting-outputs

# CI와 같은 검증
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test --platform chrome
flutter build web
```

성공 기준

- `dart format`이 변경 없이 끝나고, `flutter analyze`가 `No issues found!`로 끝납니다.
- `flutter test --platform chrome`이 모두 통과하고 `flutter build web`이 `build/web`을 생성합니다.
- 로컬 실행 시 `/login`이 열리고, Discord 로그인 후 `/select`로 이동합니다.

## 5. 설정 요약

필수 `--dart-define`: `CLIENT_ID`, `REDIRECT_URI`, `BACKEND_URI`, `ROUTE_URI`

- `.env`/`flutter_dotenv`는 사용하지 않습니다(의존성에서도 제거).
- Web 번들은 누구나 받을 수 있으므로 공개해도 되는 값만 넣습니다. 비밀값과 서버 권한 판단은 client에 두지 않습니다.
- 인증 토큰은 백엔드의 HttpOnly 쿠키로만 다룹니다.
- 채팅방 선택 후 `/api/me/module-configs`로 서버가 JWT의 `botId`에 맞춰 조회한 메뉴 설정을 받습니다. `shadowverse`·`chatbot` 모듈과 `network_operations.add_on`의 아카데미·대회 설정이 있는 기능만 표시하며, 아카데미·대회는 추가로 서버 권한을 조회합니다.
- production 값은 GitHub Actions secrets로 CD가 Docker build arg에 전달합니다.

## 6. 구조 요약

```text
lib/
├── main.dart · router/          # 앱 진입점, GoRouter와 로그인·채팅방 가드
├── core/                        # theme·token, Dio·interceptor, 봇 router client
├── shared/                      # 공용 DTO·domain·DB 편집기·widget
└── feature/                     # auth, guild_select, home, profile, notification, modules/{academy,chatbot,erp,shadowverse}
```

- 모든 feature는 `feature/modules/academy`의 `data/ · domain/ · state/ · notifier/ · pages/ · widgets/` 구조를 따릅니다. 파일·폴더 이름은 snake_case입니다.
- page → notifier(`@riverpod`) → repository(DTO ↔ domain) → API(Dio) → WebUI_BE 순서로 흐릅니다.
- `AuthInterceptor`는 401일 때만 `/auth/refresh` 후 1회 재시도합니다.

상세: [architecture](docs/architecture.md)

## 7. UI 요약

- theme: `CustomTheme` (Primary `#FFFFFF`, Secondary `#000D27`, Tertiary `#1A1A1E`, Surface `#F5F6F7`)
- breakpoint: mobile `< 500px`, tablet `< 900px`, laptop `< 1350px`, wide `≥ 1350px`
- 색·간격·크기는 `core/constants`와 feature `constants/`의 token을 씁니다.
- 비동기 화면은 loading·empty·error·success를 구분하고, 빈 값은 안내 문구로 표시합니다.

상세: [design-system](docs/design-system.md)

## 8. 테스트 요약

- 자동 테스트: `test/`는 `lib/`와 같은 경로로 나누고, 기능마다 API 테스트와 widget 테스트를 둡니다(core·shared·로그인·채팅방 선택·홈·프로필·아카데미·빗자루·섀도우버스·포인트·벌점·알림).
- 테스트 없음: 라우팅 가드, 수업 기록 작성·수정 화면, 교사 상태 처리 화면, 임시 연동 키 화면(라우트 미연결)
- CI gate: PR(→ `main`/`develope`)과 `develope` push에서 lockfile 고정 설치 → 생성 코드 일치 → format → analyze(경고·info 포함) → test(chrome) → web build, 별도로 secret scan·Docker build
- `*.g.dart`, `*.freezed.dart`는 커밋하고 직접 수정하지 않습니다.

상세: [testing](docs/testing.md)

## 9. Build·배포

- artifact: `Dockerfile` multi-stage(Flutter 3.41.2 → `nginx:1.25-alpine`, 포트 1104, SPA fallback)
- 배포: `main` push → CD가 원격 서버에서 `docker compose -p webui-fe up -d --build`
- API 계약이 바뀐 릴리스는 WebUI_BE와 같은 시점에 `main`으로 병합·배포하고 rollback도 함께 합니다.
- 성능 budget, 운영 모니터링, 담당자는 아직 정하지 않았습니다.

상세: [deploy](docs/deploy.md)

## 10. 알려진 이슈와 예외 기록 (2026-09-29 기준)

아래 항목은 동작을 바꾸지 않는 정리 범위 밖이라 남겨 두었습니다. 승인 주체와 재검토 시점은 아직 정하지 않았습니다(결정 필요).

| 항목 | 사유·영향 | 대안·후속 |
|---|---|---|
| 폰트 미등록 | `pubspec.yaml`의 `fonts:`가 `flutter:` 밖이고 경로가 `asset/`라 Noto Sans KR이 적용되지 않음. 고치면 전체 글꼴이 바뀜 | 디자인 검토 후 등록 ([design-system](docs/design-system.md#6-폰트)) |
| localization resource 없음 | ARB·fallback locale이 없음. 문자열은 `*_strings.dart`로 모아 둠 | 다국어 요구 시 ARB 도입 ([design-system](docs/design-system.md#7-국제화)) |
| 로그아웃 시 회원증 캐시 | 회원증(`membershipProvider`, keepAlive)을 로그아웃·채팅방 변경 때 비우지 않아 다른 계정으로 로그인하면 이전 회원증이 보일 수 있음 | 로그아웃 흐름에서 `clear()` 호출 검토 |
| DB 편집기 튜토리얼 key | 튜토리얼의 "삭제" 단계가 수정 버튼을, "수정" 단계가 삭제 버튼을 가리킴(`EditorBar`의 key 전달 순서) | 안내 순서와 key를 맞춤 |
| 입·출금 중복 가능성 | 포인트 입·출금 요청에 서버 요청 ID가 없어 결과를 모르는 실패 뒤 재시도하면 중복 반영될 수 있음 | WebUI_BE와 idempotency key 합의 |
| 로그인 버튼 너비 | 로그인 카드의 `Column(crossAxisAlignment: stretch)` 때문에 데스크톱 Discord 로그인 버튼이 설정한 160px이 아니라 카드 너비로 늘어남. 테스트는 설정값만 확인 | 레이아웃 수정 시 시각 검토 |
| `sample/` 스크린샷 | 현재 화면과 다를 수 있음 | 화면 변경 PR에서 갱신 |

## 11. License

- 프로젝트 license: 미정 (지정 필요)
- 아이콘 출처: [copyrights_path.md](copyrights_path.md), [assets/icons/ReadMe.md](assets/icons/ReadMe.md) (Flaticon, Freepik, UXWing 등)
- 폰트: Noto Sans KR (SIL Open Font License 1.1)
