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

| 범위 | 위치 | 검증 내용 |
|---|---|---|
| 공용 widget | `test/widget_test.dart` | loading·padding·SnackBar widget |
| 계약·유틸 | `test/api_test.dart` | 봇 router `SocketModel` 직렬화, `ApiResponse` 해석, 날짜 formatter |
| 포인트 | `test/feature/modules/erp/point/` | API 계약(직렬화·매핑), 검색·페이지 이동, 요청 경합·화면 종료·중복 제출, 작은 화면과 큰 글자, 버튼 대비, 빈 설명 |
| 벌점 | `test/feature/modules/erp/penalty/` | API 계약, 30일 누적 계산, notifier, widget |
| 알림 | `test/feature/notification/` | API 계약(경로·쿼리·UTC·요청 ID·실패 코드), 실시간 이벤트 변환·중복 제거, 패널 열기·읽음 처리, loading·error·empty, 작은 화면과 큰 글자, 발행 폼 검증과 재전송 멱등성 |

아직 자동 테스트가 없는 영역: ChatBot, Academy, Shadowverse, 프로필, 로그인·라우팅 가드.

## 3. 작성 규칙

- repository는 `support/fake_*_repository.dart` fake로 대체하고 실제 network·실제 시간에 의존하지 않습니다.
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
| 6 | `flutter test --platform chrome` |
| 7 | `flutter build web` |
| 별도 job | `docker build` |

gate가 실패하면 merge하지 않습니다. 우회가 필요하면 사유·위험·기간·후속 조치를 PR에 기록하고 승인받습니다.

## 5. 생성 코드

- `*.g.dart`, `*.freezed.dart`는 커밋합니다. 직접 수정하지 않습니다.
- `@riverpod`, `@freezed`, `@JsonSerializable`을 바꾸면 `pubspec.lock`의 버전 그대로 재생성하고 source와 같은 commit에 넣습니다.
