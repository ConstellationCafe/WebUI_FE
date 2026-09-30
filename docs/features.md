# 기능별 구현 노트

> 상태: Active  
> 마지막 검토일: 2026-09-29  
> 상위 문서: [README](../README.md) · 관련: [architecture](architecture.md), [테스트](testing.md)

API 계약은 Notion `섀버 별자리 Cafe 개발 본부 / 명세서 / API 명세서`와 [WebUI_BE API 개요](https://github.com/ConstellationCafe/WebUI_BE/blob/develope/docs/api.md)를 기준으로 합니다.

## 로그인과 채팅방 선택 (`feature/auth`, `feature/guild_select`)

- `/login`에서 Discord OAuth 페이지로 이동하고, 백엔드 callback(`/auth/discord_login`)이 쿠키를 발급한 뒤 `FRONT_REDIRECT_URI`로 돌려보냅니다. 페이지 이동은 `data/api/browser/`의 conditional import로 격리했습니다.
- `/auth/check`·`/auth/me` 응답은 `AuthCheckResponse`·`CurrentUserResponse` DTO가 해석합니다. 로그아웃(`LoginCheckNotifier.logout`)은 서버 세션 종료가 실패해도 사용자·채팅방 상태를 지웁니다.
- 로그인만으로는 `/api/**`를 쓸 수 없습니다. `/select`에서 채팅방을 고르면 `POST /auth/guild/select`로 방이 담긴 토큰을 다시 받습니다(WebUI_BE ADR-0001).
- `/home?guild_id=`는 선택이 끝났고 `guild_id`가 사용자 길드 목록에 있을 때만 열립니다.
- 채팅방 선택 요청·상태 초기화·로그인 재확인은 `CurrentGuildStateNotifier.select`가 하고, 화면은 결과(`GuildSelectionResult`)에 따라 안내·이동만 합니다.

## 메뉴와 권한 (`feature/home/frame`)

| 메뉴 | 표시 조건 |
|---|---|
| ChatBot, Shadowverse | 항상 |
| Academy | Academy 권한 조회(`/api/academy/me/permissions`)가 끝난 뒤. 교사 관리는 학원장, 학생 관리는 교사 이상 |
| ERP(포인트·벌점·알림 발행) | `UserRole.admin` (`ROLE_ADMIN`) |
| 대회(대회 개최) | 대회 권한 조회(`/api/competitions/me/permissions`)의 `manager`. 현재 채팅방에서 `대회 매니저`가 들어간 역할이 있거나 서버장 |

메뉴 숨김은 편의 기능이며, 권한 최종 판단은 서버가 합니다.

## ChatBot 저장소 (`feature/modules/chatbot`)

- `/content`, `/learning`, `/menu`, `/music` 화면은 공용 DB 편집기(`shared/widgets/db_editor`)로 목록 조회와 일괄 저장·삭제를 합니다.
- 카테고리는 Category + Search Bar + Tags 통합 검색을 지원합니다.
- 편집기 상태는 `dbEditorProvider(repository)`가 소유합니다. 조회 실패는 고정 안내(`데이터를 불러오지 못했습니다.`)로, 검색·정렬·저장 제한은 의도한 안내 문구로 보여줍니다.

## Academy (`feature/modules/academy`)

- `/academy/write_lesson_record`, `/academy/read_lesson_record`: 수업 기록 작성·조회
- `/academy/student_status`, `/academy/teacher_status`: 학생·강사 현황 수정 (빗자루 봇 router 경유)
- `/academy/read_student_status`, `/academy/read_teacher_status`: 현황 조회
- 새 feature의 기준 구조입니다([architecture](architecture.md#3-feature-구조-기준)).
- 조회·처리에 실패하면 화면 위에 `AcademyErrorBanner`로 고정 안내를 보여주고, 조회 화면은 다시 시도할 수 있습니다.

## ERP 포인트 관리 (`feature/modules/erp/point`)

- 관리자 API `/api/admin/points/**`(WebUI_BE ADR-0002)를 사용합니다.
- `notifier/`는 `@riverpod` 생성 provider, `state/`는 `@freezed` 불변 UI 상태입니다. 화면 종료 시 provider가 해제되며, 늦게 완료된 요청은 상태를 수정하지 않습니다.
- `data/dto/request`·`data/dto/response`가 API 계약을 표현하고, repository가 domain model로 변환합니다.
- 페이지는 `ConsumerWidget`입니다. 검색 입력과 제출한 검색어를 UI 상태에서 구분하고, 다이얼로그 입력 controller는 해당 위젯 `State`에서 생성·해제합니다.
- 시간대 없이 오는 UTC 일시는 DTO 경계에서 UTC로 해석하고 화면에서 현지 시각으로 표시합니다. null·빈 문자열·공백뿐인 설명은 `등록된 설명이 없습니다.`로 표시합니다.
- 입·출금 요청은 서버에 요청 ID가 없어, 결과를 모르는 실패 뒤 재시도하면 중복 반영될 수 있습니다.

## ERP 벌점 관리 (`feature/modules/erp/penalty`)

- `/penalties`(관리자): 채널·대상별 이력, 조회 시점 기준 30일 누적 점수, 재적 회원 순위와 상세, 부여·취소
- `/my-penalties`(프로필 메뉴): 본인 벌점 이력
- 서버가 JWT에서 현재 채팅방 `botId`를 꺼내므로 `botId`나 `sk`를 보내지 않습니다. 대상은 숫자 Discord ID, 점수는 1점 고정, 발생 시각은 브라우저 현지 시각을 UTC로 변환합니다.
- 요청·응답 DTO는 `data/dto`, 업무 데이터는 `domain/model`, 상태는 `state/`(Freezed)와 `notifier/`(생성형 Riverpod)로 분리합니다.
- 부여 다이얼로그는 요청 UUID를 한 번 생성해 재시도에도 유지하고, 제출 중에는 중복 제출을 막습니다. API receive timeout은 15초입니다.
- 탭 배경은 상하에만 안쪽 여백을 두어 탭 영역이 아래 목록(TabBarView)과 같은 너비를 차지합니다.

## 대회 개최 (`feature/modules/competition`)

- `/competitions`(대회 매니저, 대회 메뉴): 현재 채팅방의 대회 게시판에 평문 대회 공지를 게시합니다. WebUI_BE `/api/competitions/**`를 사용합니다.
- 권한은 아카데미처럼 로그인 사용자 정보를 불러올 때(채팅방 선택·변경 포함) `CompetitionPermissionNotifier`(keepAlive)가 조회하고 로그아웃 시 비웁니다. 조회에 실패하면 메뉴를 숨깁니다.
- 웹은 **글만 씁니다**. 서버가 봇 계정으로 디스코드에 게시하면, 빗자루 봇이 기존처럼 글을 감지해 대회 등록(스케줄러), 참가 이모지·참가자 역할·대회방 생성, WebUI 알림 발행을 처리합니다. 참가 이모지 등은 `joinable` 게시판(`inner_board`)에서만 만들어지며, 화면이 게시판을 고를 때 안내합니다.
- 입력: 제목, 참가 방법, 진행 형식, 접수 시작·마감, 진행 시작(브라우저 현지 시각을 UTC로 전송), 선택 우승 상품·추가 입력란(각 10개). 진행 기간은 항상 `시작 ~ 종료시까지`로 게시됩니다.
- 입력이 멈추면(600ms) `POST /notices/preview`로 서버가 조립한 **실제 게시글**과 봇 파서 규칙 위반 안내를 미리보기에 보여줍니다. 늦게 도착한 이전 미리보기 결과는 버립니다.
- 개최 전 확인 다이얼로그로 게시판·대회명·일정과 봇이 자동으로 하는 일을 확인받습니다. 게시 시도마다 요청 ID를 만들고 결과를 모르는 실패 뒤 다시 누르면 같은 ID를 재사용합니다(서버가 Discord nonce로 몇 분 안의 중복 게시를 막음). 성공하면 폼을 비우고 SnackBar에서 디스코드 공지글을 열 수 있습니다.
- 400·404·502 실패는 서버 안내 문구를 그대로 보여주고, API 호출은 `ErrorInterceptor.silentErrorKey`로 전역 SnackBar를 끕니다.

## 알림 (`feature/notification`)

- 설계 근거: WebUI_BE ADR-0004 (DB 저장 + Redis Pub/Sub + SSE)
- 헤더 프로필 아이콘 왼쪽의 `NotificationBell`이 읽지 않은 알림이 있으면 우측 하단에 빨간 점을 표시합니다. 누르면 패널이 열리고, 최신 알림까지 읽음 처리(`PUT /api/me/notifications/read-cursor`)되어 빨간 점이 사라집니다. 이번에 새로 본 알림은 배경색과 "새 알림" 문구로 구분합니다.
- 실시간 수신은 `EventSource`(SSE, `GET /api/me/notifications/stream`)이며 인증은 HttpOnly 쿠키로 합니다(토큰을 URL에 넣지 않음). 브라우저 구현은 `data/realtime/`에서 conditional import로 격리했고(`package:web`), 그 외 platform은 REST 조회만 합니다.
- 연결 직후 서버가 보내는 `ready` 이벤트로 읽지 않은 개수를 다시 맞추므로, 오프라인이던 동안의 알림도 접속하면 표시됩니다.
- 서버가 연결을 끝내면(토큰 만료 등) 읽지 않은 개수를 REST로 먼저 다시 받아 토큰 갱신을 거친 뒤, 2초에서 시작해 최대 60초 간격(±20% jitter)으로 재연결합니다.
- 관리자는 `/notification`에서 채팅방 전체 또는 특정 회원에게 발행하고 이력을 봅니다. 발행 시도마다 요청 ID를 만들고, 결과를 모르는 실패 뒤 다시 누르면 같은 ID를 재사용해 중복 발행을 막습니다. 링크는 `/`로 시작하는 앱 내부 경로만 허용합니다.
- 알림 API 호출은 화면이 오류를 직접 보여주므로 `ErrorInterceptor.silentErrorKey`로 전역 SnackBar를 끕니다.
- 배포 시 reverse proxy는 SSE 경로의 buffering을 끄고 read timeout을 30초 이상으로 둡니다([deploy](deploy.md)).

## 프로필 (`feature/profile`)

- `/profile`: 멤버십 정보, 카드 생성·UID·채팅방 변경(빗자루 봇 router 경유)
- `/point_log`: 본인 포인트 내역(`/api/repository/membership/point_log`)
- 봇 `create_card` 응답은 `MembershipCardResponse`가 순서대로 해석해 `Membership` domain model로 바꿉니다. 조회에 실패하면 안내와 다시 시도를 보여줍니다.

## Shadowverse 친선전 (`feature/modules/shadowverse/friendly_match`)

- `/friendly_match`: 게임 매치 등록과 참가. WebUI_BE가 아니라 빗자루 봇 router를 호출합니다.
- 요청 형식은 `FriendlyMatchRequest` DTO가 만들고, 전송은 `FriendlyMatchNotifier.submit`이 합니다. 실패하면 예외 원문 대신 고정 안내를 보여줍니다.
