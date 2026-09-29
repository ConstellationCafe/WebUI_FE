# WebUI_FE 실행과 배포

> 상태: Active  
> 마지막 검토일: 2026-09-29  
> 상위 문서: [README](../README.md) · 관련: [테스트와 CI](testing.md), [architecture](architecture.md)

## 1. 환경 요구사항

| 항목 | 요구사항 |
|---|---|
| Flutter | 3.41.2 고정 (`Dockerfile`의 `FLUTTER_VERSION`, `CI.yml`의 `flutter-version`) |
| Dart SDK | `>=3.9.0 <4.0.0` (`pubspec.yaml`) |
| 브라우저 | Chrome |
| Docker / Docker Compose | 컨테이너 빌드·배포 시 |

## 2. 설정 변수

빌드 시 `--dart-define`(Docker는 build arg)으로 주입하고 코드에서 `String.fromEnvironment`로 읽습니다. `.env` 파일과 `flutter_dotenv`는 사용하지 않습니다.

| 변수 | 필수 | 용도 | 안전한 예시 형식 |
|---|:---:|---|---|
| `CLIENT_ID` | 예 | Discord OAuth client ID | Discord 발급 값 |
| `REDIRECT_URI` | 예 | Discord OAuth redirect URI (WebUI_BE `/auth/discord_login`) | `https://example.test/auth/discord_login` |
| `BACKEND_URI` | 예 | WebUI_BE 기본 URI | `https://example.test` |
| `ROUTE_URI` | 예 | 빗자루 봇 router URI | `https://example.test/route` |

- 값은 Web 번들에 그대로 들어가 누구나 볼 수 있습니다. 공개해도 되는 값만 넣고 비밀값은 넣지 않습니다.
- production 값은 GitHub Actions secrets에 있습니다.

## 3. 로컬 실행

```sh
flutter pub get

flutter run -d chrome \
  --dart-define=CLIENT_ID=<discord_client_id> \
  --dart-define=REDIRECT_URI=<oauth_redirect_uri> \
  --dart-define=ROUTE_URI=<bot_router_uri> \
  --dart-define=BACKEND_URI=<backend_uri>

flutter build web --release --dart-define=...   # 위와 같은 값
```

로그인 쿠키가 동작하려면 WebUI_BE의 `FRONT_REDIRECT_URI`(CORS 허용 origin)가 FE 주소와 일치해야 합니다.

## 4. Docker

```sh
docker build \
  --build-arg CLIENT_ID=<client_id> \
  --build-arg REDIRECT_URI=<redirect_uri> \
  --build-arg ROUTE_URI=<route_uri> \
  --build-arg BACKEND_URI=<backend_uri> \
  -t webui_fe .

docker run -p 1104:1104 webui_fe
```

또는 같은 이름의 셸 환경 변수를 export한 뒤 Compose로 실행합니다.

```sh
docker compose up -d --build
docker compose ps
```

- build stage: Debian에 Flutter 3.41.2를 받아 `flutter build web --release`(build arg → `--dart-define`)
- runtime stage: `nginx:1.25-alpine`, 포트 **1104**, `nginx.conf`의 `try_files $uri $uri/ /index.html`로 SPA 경로(`PathUrlStrategy`)를 처리
- `.dockerignore`: `.git`, `.github`, `.dart_tool`, `build`, `coverage`, `test`, `sample`, `docs`

## 5. CI/CD

| workflow | trigger | 내용 |
|---|---|---|
| `CI.yml` | PR → `main`/`develope`, push → `develope` | lockfile 고정 설치, 생성 코드 일치 확인, format, analyze(경고·info 포함), test(chrome), `flutter build web`, secret scan, Docker build ([테스트와 CI](testing.md#4-ci-gate-githubworkflowsciyml)) |
| `CD.yml` | push → `main` | 빌드에 필요한 파일(`Dockerfile`, `docker-compose.yml`, `nginx.conf`, `pubspec.*`, `.dockerignore`, `.metadata`, `assets`, `lib`, `web`)을 SCP로 원격 서버에 전송 → `docker compose -p webui-fe up -d --build` → `ps` |

- CD는 `CLIENT_ID`, `REDIRECT_URI`, `ROUTE_URI`, `BACKEND_URI`를 secrets에서 SSH step 환경 변수로 넘겨 Compose build arg로 씁니다.
- 작업 흐름: 기능 브랜치 → `develope` PR(CI 통과) → `main` 병합 시 배포.

## 6. 배포 순서와 rollback

- WebUI_BE API 계약이 바뀐 릴리스는 BE와 FE를 **같은 시점에** `main`으로 병합·배포하고 rollback도 함께 합니다(WebUI_BE ADR-0002). BE migration이 필요한 경우 BE 배포가 먼저입니다.
- rollback: 이전 검증 완료 commit을 `main`에 되돌려(revert) 다시 배포합니다.

## 7. reverse proxy

- 앞단 proxy·TLS는 서버 구성에 따릅니다.
- 실시간 알림 SSE(`/api/me/notifications/stream`)는 WebUI_BE로 가는 경로이며, proxy가 있으면 응답 buffering을 끄고 read timeout을 30초 이상으로 둡니다(서버 heartbeat 25초).
