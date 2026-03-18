## 🚀 실행 방법

### 환경 요구사항
- **Flutter SDK**: 3.6.1+
- **Dart**: 3.6.1+

### 로컬 실행
```bash
# 의존성 설치
flutter pub get

# 웹 디버그 모드 실행
flutter run -d chrome

# 웹 릴리즈 빌드
flutter build web --release
```

### 환경 변수
런타임 시 다음 환경 변수가 필요합니다:
- `CLIENT_ID`: Discord OAuth Client ID
- `REDIRECT_URI`: OAuth 리다이렉트 URI
- `ROUTE_URI`: 라우팅 기본 URI
- `BACKEND_URI`: 백엔드 서버 URI

## 🐳 Docker 배포

### Dockerfile 빌드
```bash
docker build \
  --build-arg CLIENT_ID=<client_id> \
  --build-arg REDIRECT_URI=<redirect_uri> \
  --build-arg ROUTE_URI=<route_uri> \
  --build-arg BACKEND_URI=<backend_uri> \
  -t constellation-cafe-webui .
```

### 컨테이너 실행
```bash
docker run -p 1104:1104 constellation-cafe-webui
```

애플리케이션은 포트 1104에서 실행됩니다.