# 🌟 빗자루 WebUI 프로젝트
**빗자루**는 섀버 별자리 Cafe에서 개발 및 운영하는 채팅 봇으로, 섀도우버스 관련 편의 기능부터 채팅방 운영에 필요한 도구들을 제공합니다.

## 📋 프로젝트 개요
기존 명령어 기반의 봇 조작 및 기능 구현 한계를 극복하기 위해, WebUI 환경을 제공하는 것입니다.

## 🎨 디자인 시스템

### 컬러 스킴
- **Primary**: `#ffffff` (흰색)
- **Secondary**: `#000D27` (진한 남색)  
- **Tertiary**: `#1A1A1E` (진한 회색)
- **Surface**: `#F5F6F7` (연한 회색)

### 폰트
- **기본 폰트**: Noto Sans KR
- 다양한 weight 지원 (Thin, Light, Regular, Medium, SemiBold, Bold, ExtraBold, Black)

### 반응형 디자인
- **데스크톱**: 기본 (1350px 이하)
- **모바일**: 기본 (450px 이하)
- **와이드스크린**: 미지원
- **태블릿**: 미지원 (900px 이하)

## 🏗️ 아키텍처

### 폴더 구조
```
lib/
├── core/                   # 핵심 유틸리티 및 공통 컴포넌트
│   ├── constants/          # 상수 정의 (테마, 패딩, 화면 크기 등)
│   ├── di/                 # 의존성 주입 (API, Repository Provider)
│   ├── domain/             # 도메인 모델 (UserRole 등)
│   ├── network/            # 네트워크 계층 (인증, Discord Bot, 인터셉터)
│   ├── state/              # 전역 상태 관리 (Riverpod)
│   └── widgets/            # 재사용 가능한 위젯
├── data/                   # 데이터 계층
│   ├── api/                # API 통신 (인증, 백엔드, Discord Bot)
│   └── model/              # 데이터 모델 (Entity, Request, Response)
├── domain/                 # 비즈니스 로직
│   ├── Common/             # 공통 도메인
│   ├── FriendlyMatch/      # 친선전 관련 도메인
│   ├── Login/              # 로그인 관련 도메인
│   └── User/               # 사용자 관련 도메인
├── feature/                # 기능별 UI 컴포넌트
│   ├── auth/               # 인증 (로그인)
│   ├── contents/           # 콘텐츠 (친선전, 학습, 메뉴, 음악)
│   ├── home/               # 홈 페이지
│   └── user/               # 사용자 프로필
└── routes/                 # 라우팅 설정
```

### 상태 관리
- **Flutter Riverpod** 사용
- Provider 패턴으로 전역 상태 관리
- 각 기능별로 독립적인 상태 관리

### 네트워킹
- **Dio** HTTP 클라이언트 사용
- Cookie 관리 지원
- JWT 기반 인증 인터셉터
- Discord Bot과의 Socket 통신

## 🔐 인증 시스템

### Discord OAuth 2.0
- Discord 계정을 통한 로그인
- JWT 토큰 & 세션 기반 인증

## 📱 주요 기능

### 사용자 기능
- **친선전 게시판**: 게임 매치 등록 및 참가
- **학습 자료**: 학습 콘텐츠 조회
- **추천 시스템**: 메뉴, 음악, 콘텐츠 추천
- **프로필 관리**: 멤버십 정보 관리

### 관리자 기능
- **포인트 관리**: 사용자 포인트 시스템 관리
- **대회 공지**: 별자리 내/외부 대회 공지

### UI 컴포넌트
- **데이터베이스 에디터**: 실시간 DB 편집 도구
- **반응형 메뉴바**: 사용자 권한별 메뉴 표시

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
  --build-arg CLIENT_ID=your_client_id \
  --build-arg REDIRECT_URI=your_redirect_uri \
  --build-arg ROUTE_URI=your_route_uri \
  --build-arg BACKEND_URI=your_backend_uri \
  -t constellation-cafe-webui .
```

### 컨테이너 실행
```bash
docker run -p 1104:1104 constellation-cafe-webui
```

애플리케이션은 포트 1104에서 실행됩니다.

## 📚 사용된 주요 라이브러리

### 핵심 라이브러리
- `flutter_riverpod`: ^2.6.1 (상태 관리)
- `go_router`: ^16.0.0 (라우팅)
- `dio`: ^5.4.0 (HTTP 클라이언트)

### 인증 & 네트워킹
- `flutter_web_auth_2`: ^3.0.0 (웹 OAuth)
- `dio_cookie_manager`: ^3.0.0 (쿠키 관리)
- `cookie_jar`: ^4.0.0 (쿠키 저장소)

### UI & UX
- `image_picker`: ^1.1.2 (이미지 선택)
- `url_launcher`: ^6.2.10 (URL 실행)
- `intl`: ^0.18.1 (국제화)

### 개발 도구
- `flutter_dotenv`: ^5.2.1 (환경 변수 관리)

## 📄 라이선스

이 프로젝트에서 사용된 아이콘들의 출처:
- FriendlyMatch Icon: [Flaticon](https://www.flaticon.com/kr/free-icons)
- Learning Icon: [Muhammad Waqas Khan](https://www.flaticon.com/kr/authors/muhammad-waqas-khan)
- Menu Icon: [Prosymbols Premium](https://www.flaticon.com/kr/authors/prosymbols-premium)
- Music Icon: [Freepik](https://www.freepik.com)
- Playing Icon: [Alimasykurm](https://www.flaticon.com/kr/authors/alimasykurm)
- Coin Icon: [Satria Arnata](https://www.flaticon.com/kr/authors/satria-arnata)

## 🛠️ 개발 참고사항

### 페이지 구조 가이드라인
- **HomePage**와 **LoginPage**: Scaffold 사용
- **기타 페이지**: ShellRoute의 하위로 구성하여 Widget 사용

### API 사용법
- `lib/data/api`를 통해 API 호출
- 내부적으로 `lib/core/network`를 통해 백엔드나 빗자루에 API 요청

### 카테고리 설계
- 통합 검색 지원 (Category + Search Bar + Tags)
- 사용자/관리자 영역 분리된 카테고리 구조