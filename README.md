# 🌟 빗자루 WebUI 프로젝트
[**빗자루**](https://github.com/ConstellationCafe/DiscordBot)는 섀버 별자리 Cafe에서 개발 및 운영하는 채팅 봇으로, 섀도우버스 관련 편의 기능부터 채팅방 운영에 필요한 도구들을 제공합니다.

## 📋 프로젝트 개요
기존 명령어 기반의 봇 조작 및 기능 구현 한계를 극복하기 위해, WebUI 환경을 제공

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
- **태블릿**: 기본 (900px 이하)

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
- **알림**: 우측 상단 종 아이콘으로 공지·포인트 등 알림을 실시간 수신, 읽지 않은 알림은 빨간 점으로 표시
- **친선전 게시판**: 게임 매치 등록 및 참가
- **학습 자료**: 학습 콘텐츠 조회
- **추천 시스템**: 메뉴, 음악, 콘텐츠 추천
- **프로필 관리**: 멤버십 정보 관리

### 관리자 기능
- **포인트 관리**: 사용자 포인트 시스템 관리
- **알림 발행**: 채팅방 전체 또는 특정 회원에게 알림 발행, 발행 이력 조회
- **대회 공지**: 별자리 내/외부 대회 공지

### UI 컴포넌트
- **데이터베이스 에디터**: 실시간 DB 편집 도구
- **반응형 메뉴바**: 사용자 권한별 메뉴 표시

## 📚 사용된 주요 라이브러리

### 핵심 라이브러리
- `flutter_riverpod`: ^3.3.1 (상태 관리)
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
- 
### 카테고리 설계
- 통합 검색 지원 (Category + Search Bar + Tags)
- 사용자/관리자 영역 분리된 카테고리 구조

### ERP 포인트 관리
- 구현 위치: `lib/feature/modules/erp/point/`.
- `notifier/`는 `@riverpod` 자동 생성 provider, `state/`는 `@freezed` 불변 UI 상태를 사용한다. 화면 종료 시 provider가 해제되며, 늦게 완료된 요청은 상태를 수정하지 않는다.
- `data/dto/request`와 `data/dto/response`는 membership 포인트 API 계약을 표현한다. API에서 JSON을 DTO로 변환하고 repository에서 domain model로 변환한다.
- 페이지는 `ConsumerWidget`이다. 검색 입력과 제출한 검색어는 UI 상태에서 구분하며, 다이얼로그 입력 controller는 해당 위젯의 `State`에서 생성·해제한다.
- 백엔드가 시간대 없이 반환하는 UTC 일시는 DTO 경계에서 UTC로 해석하고 화면에서 현지 시각으로 표시한다. null·빈 문자열·공백뿐인 설명은 “등록된 설명이 없습니다.”로 표시한다.
- `*.g.dart`, `*.freezed.dart` 생성 결과는 커밋한다. 의존성은 `pubspec.lock`을 사용하며, annotation 버전을 바꾸지 않고 다음 명령으로 재생성·검증한다.

```sh
flutter pub get
dart run build_runner build
dart format lib/feature/modules/erp/point test/feature/modules/erp/point
dart analyze lib/feature/modules/erp/point test/feature/modules/erp/point
flutter test test/feature/modules/erp/point
flutter build web
```

포인트 테스트는 API 직렬화·매핑, 검색 및 페이지 이동, 요청 경합·화면 종료·중복 제출, 작은 화면과 큰 글자, 공통 테마 버튼의 대비 및 빈 설명을 검증한다.

### ERP 벌점 관리
- 위치: `lib/feature/modules/erp/penalty/`. 관리자 메뉴의 `/penalties`에서 채널·대상별 벌점 이력, 조회 시점 기준 30일 누적 점수, 재적 회원 순위와 상세를 보고 벌점을 부여·취소합니다. 프로필 메뉴의 `/my-penalties`에서 본인 벌점 이력을 봅니다.
- 서버가 JWT에서 현재 채팅방 `botId`를 꺼내므로 프런트는 `botId`나 `sk`를 보내지 않습니다. 대상은 숫자 Discord ID로 입력하며 점수는 1점 고정입니다. 발생 시각 입력은 브라우저 현지 시각에서 UTC로 변환합니다.
- 요청·응답 DTO는 `data/dto/request`, `data/dto/response`, 업무 데이터는 `domain/model`, 상태는 `state/`의 Freezed와 `notifier/`의 생성형 Riverpod으로 분리합니다. 부여 다이얼로그는 요청 UUID를 한 번 생성하고 중복 제출을 막습니다.
- 생성 코드를 수동 수정하지 않고 `flutter pub get` 이후 `dart run build_runner build`로 `*.g.dart`, `*.freezed.dart`를 생성·커밋합니다. `dart format lib/feature/modules/erp/penalty test/feature/modules/erp/penalty`, `flutter analyze`, `flutter test --platform chrome`, `flutter build web`으로 확인합니다.
### 알림 (종 아이콘)
- 구현 위치: `lib/feature/notification/`. 설계 근거는 WebUI_BE의 ADR-0004(DB 저장 + Redis Pub/Sub + SSE)이다.
- 헤더 우측 상단 프로필 아이콘 왼쪽의 `NotificationBell`이 읽지 않은 알림이 있으면 우측 하단에 빨간 점을 표시한다. 누르면 알림 패널이 열리고, 가장 최신 알림까지 읽음 처리(`PUT /api/me/notifications/read-cursor`)되어 빨간 점이 사라진다. 이번에 새로 본 알림은 패널에서 배경색과 "새 알림" 문구로 구분한다.
- 실시간 수신은 `EventSource`(SSE, `GET /api/me/notifications/stream`)를 쓴다. 인증은 기존 HttpOnly 쿠키로 하며 토큰을 URL에 넣지 않는다. 브라우저 전용 구현은 `data/realtime/`에서 conditional import로 격리했고(`package:web`, `dart:html` 미사용), 그 외 플랫폼은 REST 조회만 한다.
- 연결 직후 서버가 보내는 `ready` 이벤트로 읽지 않은 개수를 다시 맞추므로, 오프라인이던 동안의 알림도 접속하면 빨간 점으로 표시된다. 서버가 연결을 끝내면(토큰 만료 등) 읽지 않은 개수를 REST로 먼저 다시 받아 토큰 갱신을 거친 뒤 2초에서 시작해 최대 60초 간격(±20% jitter)으로 다시 연결한다.
- 관리자는 ERP 메뉴의 "알림 발행"(`/notification`)에서 채팅방 전체 또는 특정 회원에게 알림을 발행하고 발행 이력을 본다. 발행 시도마다 요청 ID를 만들고, 결과를 알 수 없는 실패 뒤 다시 누르면 같은 ID를 재사용해 중복 발행을 막는다. 링크는 `/`로 시작하는 앱 내부 경로만 허용한다.
- 알림 API 호출은 화면이 오류 상태를 직접 보여주므로 `ErrorInterceptor.silentErrorKey`로 전역 오류 SnackBar를 끈다.
- 배포 시 reverse proxy를 두면 `/api/me/notifications/stream` 응답 buffering을 끄고 read timeout을 30초 이상으로 둔다(서버 heartbeat 25초).
- 알림 테스트는 API 계약(경로·쿼리·직렬화·UTC·요청 ID·실패 코드), 실시간 이벤트 변환·중복 제거, 패널 열기와 읽음 처리, loading·error·empty 상태, 작은 화면과 큰 글자, 발행 폼 검증과 재전송 멱등성을 검증한다.

```sh
flutter test test/feature/notification
```
---

## 📚 **참조 자료**
- [배포 가이드](./docs/deploy.md): 로컬 및 클라우드 환경 배포 절차

---
