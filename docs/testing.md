# 테스트와 CI

> 상태: Active  
> 마지막 검토일: 2026-09-28  
> 상위 문서: [README](../README.md) · 관련: [기능별 구현 노트](features.md)

## 1. 실행

```sh
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # 생성 코드가 바뀐 경우

flutter test --platform chrome                        # 전체
flutter test --platform chrome test/feature/notification   # 특정 feature 예시
```

`package:web`을 쓰는 코드가 있어 CI와 같이 `--platform chrome`으로 실행합니다. 웹 coverage 수집은 현재 toolchain에서 안정적이지 않아 CI에서 켜지 않습니다.

## 2. 범위

`test/`는 `lib/`와 같은 경로로 나눕니다. 예: `lib/feature/auth` → `test/feature/auth`, `lib/core` → `test/core`.
기능마다 API 테스트(`*_api_test.dart`, `*_api_contract_test.dart`)와 widget 테스트를 둡니다. 화면만 있는 기능(`home`)은 widget 테스트만 둡니다.

| 범위 | 위치 | 검증 내용 |
|---|---|---|
| core | `test/core/` | 401 토큰 갱신 후 재요청, 403·갱신 실패 처리, 오류 SnackBar 문구와 silent 요청 |
| shared | `test/shared/` | 봇 router `SocketModel` 직렬화, `ApiResponse` 해석, 날짜 formatter, loading·padding·SnackBar widget |
| 로그인 | `test/feature/auth/` | `/auth/me`·check·refresh·logout 계약, Discord 인증 URI, 로그인 상태 판정(채팅방 선택·refresh 힌트·401), 로그인 화면·버튼·큰 글자 |
| 채팅방 선택 | `test/feature/guild_select/` | 목록·선택 API(403 처리), 목록·빈 상태·오류, 선택 불가 안내, 선택 후 로그인 재확인과 홈 이동 |
| 홈 | `test/feature/home/` | 권한별 메뉴(아카데미·ERP), 메뉴 이동, 모바일 drawer, 로그아웃 후 상태 초기화 |
| 프로필 | `test/feature/profile/` | 회원증·UID·길드 봇 명령, 포인트 내역 API, 변경분만 저장, 저장 결과·실패 안내, 읽기 전용 내역 표 |
| 아카데미 | `test/feature/modules/academy/` | 권한·학원·분반·수업 기록·학생/교사 상태 API, 권한별 선택지, 졸업 처리, 상태 조회 화면, 수업 기록 카드, 페이지 버튼, 메뉴 권한 |
| 빗자루 | `test/feature/modules/chatbot/` | 가르치기·추천 저장소의 컬럼명 변환과 저장·삭제 본문, 관리자 전용 컬럼, 메뉴 이동 |
| 섀도우버스 | `test/feature/modules/shadowverse/` | 친선전 전송 형식, 봇 router 요청·오류, 미리보기·버전 전환·전송 결과, 모바일 배치 |
| 포인트 | `test/feature/modules/erp/point/` | API 계약(직렬화·매핑), 검색·페이지 이동, 요청 경합·화면 종료·중복 제출, 작은 화면과 큰 글자, 버튼 대비, 빈 설명 |
| 벌점 | `test/feature/modules/erp/penalty/` | API 계약, 30일 누적 계산, notifier, widget |
| 알림 | `test/feature/notification/` | API 계약(경로·쿼리·UTC·요청 ID·실패 코드), 실시간 이벤트 변환·중복 제거, 패널 열기·읽음 처리, loading·error·empty, 작은 화면과 큰 글자, 발행 폼 검증과 재전송 멱등성 |

아직 자동 테스트가 없는 영역: 라우팅 가드(`router_provider.dart`), 수업 기록 작성·수정 화면, 교사 상태 처리 화면.

## 3. 작성 규칙

- repository는 `support/fake_*_repository.dart` fake로 대체하고 실제 network·실제 시간에 의존하지 않습니다.
- 공용 테스트 대역은 `test/support/`에 둡니다.
  - `FakeBackend`: Dio HTTP 어댑터를 바꿔 등록한 응답을 돌려줍니다. **API 테스트에서만** 씁니다.
  - `FakeTranslator`: 봇 router 호출 경로와 인자를 기록합니다.
  - `FakePageRepository`, `FakeAcademyApi`: widget 테스트용 데이터 계층입니다. widget 테스트는 가짜 시간에서 실행되므로 Dio를 거치면 타이머가 남아 실패합니다.
  - `setScreenSize`: `MediaQuery` 크기까지 바꿉니다. `setSurfaceSize`는 `MediaQuery`를 바꾸지 않으므로 화면 폭으로 레이아웃을 고르는 widget에는 이 함수를 씁니다.
- 튜토리얼(`Usage`)이 있는 화면은 `SharedPreferences.setMockInitialValues`로 해당 key를 true로 두어 오버레이를 건너뜁니다.
- DTO를 추가·변경하면 field, nullability, enum, 날짜·시간 직렬화를 Backend 계약과 대조하는 contract test를 함께 둡니다.
- loading·empty·error·success와 submitting 상태, 작은 화면·큰 글자를 widget test로 확인합니다.
- test data에 비밀값이나 실사용 개인정보를 넣지 않습니다.
- flaky test는 재시도로 숨기지 않고 원인을 고치거나 격리 사실과 책임자를 PR에 적습니다.

## 4. CI gate (`.github/workflows/CI.yml`)

trigger: PR → `main`/`develope`, push → `develope`

| 순서 | 단계 |
|---|---|
| 1 | `flutter pub get` (Flutter `stable` channel) |
| 2 | `dart run build_runner build --delete-conflicting-outputs` |
| 3 | 벌점 feature 생성 결과를 `penalty-generated-code` artifact로 업로드 |
| 4 | `dart format --output=none --set-exit-if-changed .` |
| 5 | `flutter analyze --no-fatal-warnings --no-fatal-infos` (기존 warning/info는 차단하지 않음, 변경한 코드의 새 경고는 제거) |
| 6 | `flutter test --platform chrome --reporter github` (실패한 테스트를 PR annotation으로 표시) |
| 7 | `flutter build web` |
| 별도 job | `docker build` |

gate가 실패하면 merge하지 않습니다. 우회가 필요하면 사유·위험·기간·후속 조치를 PR에 기록하고 승인받습니다.

## 5. 생성 코드

- `*.g.dart`, `*.freezed.dart`는 커밋합니다. 직접 수정하지 않습니다.
- `@riverpod`, `@freezed`, `@JsonSerializable`을 바꾸면 `pubspec.lock`의 버전 그대로 재생성하고 source와 같은 commit에 넣습니다.
