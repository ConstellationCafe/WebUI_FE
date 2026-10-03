# 디자인 시스템과 UI 규칙

> 상태: Active  
> 마지막 검토일: 2026-10-03  
> 상위 문서: [README](../README.md) · 관련: [architecture](architecture.md)

## 1. theme

`lib/core/constants/theme_data.dart`의 `CustomTheme.themeData`를 `MaterialApp`에 적용합니다.

| 역할 | 값 | 비고 |
|---|---|---|
| Primary | `#FFFFFF` | onPrimary = Secondary |
| Secondary | `#000D27` | 진한 남색, onSecondary = Primary |
| Tertiary | `#1A1A1E` | 진한 회색 |
| Surface | `#F5F6F7` | onSurface = Tertiary |
| Input fill | `#F7F8FA` | |
| Error | `#D32F2F` | errorContainer `#FFEBEE` |
| 배경 gradient | `#F5F7FA` → `#C3CFE2` | `ConstColor` |

## 2. design token

| 위치 | 내용 |
|---|---|
| `core/constants/const_padding.dart` | 공통 padding |
| `core/constants/const_size.dart` | 공통 글자 크기(12~18), 간격(8 배수), 너비 |
| `core/constants/const_shadow.dart` | 그림자 |
| `core/constants/const_color.dart` | theme 밖 공통 색 |
| `shared/constants/db_editor_*.dart` | DB 편집기 색·크기·문구 |
| `shared/constants/snack_bar_tokens.dart`, `loading_tokens.dart` | 공용 SnackBar·진행 표시 |
| `shared/constants/date_time_picker_tokens.dart`, `date_time_picker_strings.dart` | 공용 날짜·시간 입력란과 선택기 색·문구 |
| `shared/widgets/usage/constants/` | 튜토리얼 안내 token·문구 |
| `feature/**/constants/*_tokens.dart`, `*_strings.dart`, `*_constants.dart` | feature 전용 token·문자열 |

- 같은 magic value를 반복하지 않고 token을 씁니다. 의미가 다르면 값이 같아도 억지로 합치지 않습니다.
- form에서 label·입력란·설명처럼 의미가 다른 행은 token 기반 `SizedBox`나 layout spacing으로 띄웁니다.

## 3. 반응형 breakpoint (`ScreenWidth`)

| 구분 | 폭 |
|---|---|
| mobile | `< 500px` |
| tablet | `500 ~ 899px` |
| laptop | `900 ~ 1349px` |
| wide | `≥ 1350px` |

`ScreenWidth.isDesktop()`은 laptop 이상입니다. 작은 화면과 큰 화면에서 핵심 action과 content 우선순위를 확인합니다.

## 4. 컴포넌트 규칙

- 비동기 화면은 loading·empty·error·success를 구분하고, 필요하면 refreshing·submitting 상태를 추가합니다.
- 비어 있는 설명·내역은 빈 칸으로 두지 않고 `등록된 설명이 없습니다.`처럼 맥락에 맞는 안내 문구를 표시합니다.
- dialog의 확인·취소 버튼은 app theme과 기존 feature의 버튼 convention을 따릅니다. 보조 action이라는 이유만으로 `OutlinedButton`을 쓰지 않고, 정상·hover·focus·disabled 상태에서 글자와 배경 대비를 확인합니다.
- 제출 중인 버튼은 비활성화해 중복 실행을 막습니다.
- 날짜·시간 입력은 `shared/widgets/date_time/DateTimePickerField`(날짜·시간을 따로 눌러 고르는 입력란)를 씁니다. 텍스트로 `YYYY-MM-DD HH:mm`을 직접 입력받지 않습니다.
- 시간 입력은 모두 `shared/widgets/date_time/app_time_picker.dart`의 `showAppTimePicker`(테마: `AppTimePickerTheme`)로 고릅니다. `showTimePicker`를 직접 부르지 않습니다. 시각만 고르는 버튼은 `AppTimeButton`을 씁니다(아카데미 수업 시간 선택기를 shared로 옮긴 것).
- `showDatePicker`의 `builder`에는 `AppDatePickerTheme`을 씌웁니다. primary가 흰색이라 기본 선택기는 선택한 날짜·확인 버튼이 보이지 않으며, `AppDatePickerTheme`이 secondary 색을 적용합니다.
- 셸(`HomeFrame`) 위에 뜨는 패널은 본문 영역 기준으로 배치합니다. 예: 알림 패널은 본문 영역 우측 상단에서 위쪽·오른쪽 간격을 같게 둡니다.
- 조회 조건 묶음 옆에 조회·초기화 버튼을 두고, 조회 결과가 비면 빈 상태 안내를 조건 아래 남은 영역의 가운데에 둡니다(예: 수업 내용 조회).

## 5. 접근성

- 포인트·벌점·알림 widget test에서 작은 화면, 큰 글자(text scaling), 버튼 대비, semantics를 확인합니다.
- 색만으로 의미를 전달하지 않습니다(예: 새 알림은 배경색과 "새 알림" 문구를 함께 사용).
- 다른 feature의 keyboard·focus·screen reader 검증은 아직 체계화되지 않았습니다.

## 6. 폰트

- 의도: Noto Sans KR (`assets/fonts/NotoSansKR`, Thin~Black), theme의 `fontFamily: "Noto Sans KR"`.
- **알려진 차이(예외 기록)**: `pubspec.yaml`의 `fonts:`가 `flutter:` 아래가 아니고 경로도 `asset/`(실제는 `assets/`)라 폰트가 등록되지 않아 브라우저 기본 폰트로 보입니다.
  - 고치면 모든 화면의 글꼴·줄 높이가 바뀌므로 동작 변경 없는 정리 PR에서는 제외했습니다.
  - 영향: 디자인 의도와 실제 글꼴이 다릅니다. 대안: 폰트 등록 후 주요 화면 시각 검토.
  - 승인 주체·재검토 시점: 미정 — 디자인 담당자 지정 후 결정 필요.

## 7. 국제화

- 한국어 단일 locale입니다. 사용자 노출 문자열은 widget에 흩어 두지 않고 feature별 `constants/*_strings.dart`(공용은 `shared/constants`, `core/network/network_strings.dart`)에 모읍니다. 문장은 문자열 결합 대신 `*_strings.dart`의 함수로 만듭니다.
- Backend·봇 router 계약값(예: 친선전 모드 이름, 분반 상태 `운영`)은 domain에 둡니다.
- **예외 기록**: localization resource(ARB), fallback locale, 번역 누락 동작은 아직 도입하지 않았습니다.
  - 사유: 모든 widget이 `AppLocalizations`를 거치도록 바꾸는 작업이라 동작 변경 없는 정리 범위를 넘습니다. 문자열은 `*_strings.dart`로 모아 ARB로 옮기기 쉬운 상태입니다.
  - 영향: 다국어를 지원하지 않습니다. 승인 주체·재검토 시점: 미정 — 다국어 요구가 생기면 결정 필요.
- 날짜·시간은 `core/utils/date_formatter.dart`와 `intl`로 현지 시각 표시합니다.

## 8. 아이콘

- 메뉴 아이콘: `assets/icons/modules/{academy,chatbot,erp,shadowverse}/` (SVG)
- 출처와 license: [copyrights_path.md](../copyrights_path.md), [assets/icons/ReadMe.md](../assets/icons/ReadMe.md)
