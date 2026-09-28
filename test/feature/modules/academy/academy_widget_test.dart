import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/core/constants/theme_data.dart';
import 'package:constellation_cafe/feature/modules/academy/category/academy_category.dart';
import 'package:constellation_cafe/feature/modules/academy/data/api/student_status_api.dart';
import 'package:constellation_cafe/feature/modules/academy/data/dto/request/status_query_request.dart';
import 'package:constellation_cafe/feature/modules/academy/data/dto/response/student_status_list_response.dart';
import 'package:constellation_cafe/feature/modules/academy/data/dto/response/student_status_response.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/academy_permission.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/lesson_record/lesson_record_update.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/lesson_record/lesson_record_view.dart';
import 'package:constellation_cafe/feature/modules/academy/notifier/permission_notifier/academy_permission_notifier.dart';
import 'package:constellation_cafe/feature/modules/academy/page/read_student_status/read_student_status.dart';
import 'package:constellation_cafe/feature/modules/academy/state/permission_state/academy_permission_state.dart';
import 'package:constellation_cafe/feature/modules/academy/widgets/read_lesson_record/lesson_record_card.dart';
import 'package:constellation_cafe/feature/modules/academy/widgets/read_lesson_record/lesson_record_list.dart';
import 'package:constellation_cafe/feature/modules/academy/widgets/read_status/status_pagination.dart';

import '../../../support/fake_translator.dart';
import '../../../support/screen.dart';
import 'support/academy_fixtures.dart';

/// 위젯 테스트용 학생 상태 API. HTTP 계약은 academy_api_test에서 검증한다.
class FakeStudentStatusApi extends StudentStatusApi {
  FakeStudentStatusApi() : super(translator: FakeTranslator(), dio: Dio());

  final List<StatusQueryRequest> searches = [];

  @override
  Future<StudentStatusResponse> getStatusOptions({
    int? academyId,
    int? classId,
  }) async {
    return StudentStatusResponse.fromJson(studentOptions());
  }

  @override
  Future<StudentStatusListResponse> getStudentStatuses(
    StatusQueryRequest request,
  ) async {
    searches.add(request);
    return StudentStatusListResponse.fromJson(studentStatusPage());
  }
}

AcademyPermissionState permissionState(String role) {
  final permission = AcademyPermission.fromJson(permissionJson(role: role));
  return AcademyPermissionState(isInitialized: true, permission: permission);
}

LessonRecordView lessonRecord({bool canModify = true, String? description}) {
  return LessonRecordView(
    id: '10',
    academyName: '별빛 아카데미',
    className: '1',
    subjectName: '덱 빌딩',
    educationDate: DateTime(2026, 9, 7),
    startTime: DateTime(2026, 9, 7, 19),
    endTime: DateTime(2026, 9, 7, 20, 30),
    educationDuration: const Duration(minutes: 90),
    mainTeacherName: '박해',
    description: description ?? '',
    memberCount: 4,
    canModify: canModify,
  );
}

Widget material(Widget child) {
  return MaterialApp(
    theme: CustomTheme.themeData,
    home: Scaffold(body: SingleChildScrollView(child: child)),
  );
}

Future<void> noUpdate(LessonRecordView _, LessonRecordUpdate _) async {}

Future<void> noDelete(LessonRecordView _) async {}

void main() {
  group('학생 상태 조회 화면', () {
    late FakeStudentStatusApi api;

    Future<void> pumpPage(WidgetTester tester) async {
      setScreenSize(tester, const Size(1400, 1600));
      api = FakeStudentStatusApi();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            academyPermissionProvider.overrideWithValue(
              permissionState('ACADEMY_OWNER'),
            ),
            studentStatusApiProvider.overrideWithValue(api),
          ],
          child: MaterialApp(
            theme: CustomTheme.themeData,
            home: const Scaffold(body: ReadStudentStatusPage()),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('조회 전에는 빈 명단 안내와 0명 요약을 보여준다', (tester) async {
      await pumpPage(tester);

      expect(find.text('학생 상태 조회'), findsWidgets);
      expect(find.text('조회된 학생이 없습니다.'), findsOneWidget);
      expect(find.text('0명'), findsNWidgets(5));
    });

    testWidgets('조회하면 명단과 상태 배지, 변경 사유를 표에 채운다', (tester) async {
      await pumpPage(tester);

      await tester.tap(find.text('조회'));
      await tester.pumpAndSettle();

      expect(api.searches.single.page, 1);
      expect(find.text('김별'), findsOneWidget);
      expect(find.text('이달'), findsOneWidget);
      expect(find.text('과정 수료'), findsOneWidget);
      expect(find.text('2026-09-01'), findsNWidgets(2));
      expect(find.text('조회된 학생이 없습니다.'), findsNothing);
      expect(find.text('2명'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  group('수업 기록 카드', () {
    testWidgets('수정 권한이 없으면 수정·삭제 버튼을 숨긴다', (tester) async {
      await tester.pumpWidget(
        material(
          LessonRecordCard(
            record: lessonRecord(canModify: false),
            onUpdate: noUpdate,
            onDelete: noDelete,
          ),
        ),
      );

      expect(find.text('덱 빌딩'), findsOneWidget);
      expect(find.text('수업 시간: 19:00 ~ 20:30 · 90분'), findsOneWidget);
      expect(find.text('작성된 수업 내용이 없습니다.'), findsOneWidget);
      expect(find.byTooltip('수업 기록 수정'), findsNothing);
      expect(find.byTooltip('수업 기록 삭제'), findsNothing);
    });

    testWidgets('삭제를 확인하면 해당 기록 삭제를 요청한다', (tester) async {
      final deleted = <String>[];
      await tester.pumpWidget(
        material(
          LessonRecordCard(
            record: lessonRecord(description: '실전 연습'),
            onUpdate: noUpdate,
            onDelete: (record) async => deleted.add(record.id),
          ),
        ),
      );

      await tester.tap(find.byTooltip('수업 기록 삭제'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('취소'));
      await tester.pumpAndSettle();
      expect(deleted, isEmpty);

      await tester.tap(find.byTooltip('수업 기록 삭제'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, '삭제'));
      await tester.pumpAndSettle();

      expect(deleted, ['10']);
      expect(find.text('실전 연습'), findsOneWidget);
    });

    testWidgets('조회된 기록이 없으면 빈 상태를 안내한다', (tester) async {
      await tester.pumpWidget(
        material(
          const LessonRecordList(
            records: [],
            onUpdate: noUpdate,
            onDelete: noDelete,
          ),
        ),
      );

      expect(find.text('조회된 수업 기록이 없습니다.'), findsOneWidget);
    });
  });

  testWidgets('페이지 버튼은 범위 안에서만 이동을 요청한다', (tester) async {
    final pages = <int>[];
    await tester.pumpWidget(
      material(
        StatusPagination(
          currentPage: 1,
          totalPages: 3,
          onPageChanged: pages.add,
        ),
      ),
    );

    final previous = find.widgetWithIcon(IconButton, Icons.chevron_left);
    expect(tester.widget<IconButton>(previous).onPressed, isNull);

    await tester.tap(find.text('3'));
    await tester.tap(find.widgetWithIcon(IconButton, Icons.chevron_right));

    expect(pages, [3, 2]);
  });

  group('아카데미 메뉴', () {
    Future<void> pumpCategory(WidgetTester tester, String role) async {
      setScreenSize(tester, const Size(800, 1000));
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => const Scaffold(body: AcademyCategory()),
          ),
        ],
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            academyPermissionProvider.overrideWithValue(permissionState(role)),
          ],
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('원장은 교사 관리 메뉴까지 본다', (tester) async {
      await pumpCategory(tester, 'ACADEMY_OWNER');

      expect(find.text('아카데미 메뉴'), findsOneWidget);
      expect(find.text('교사 관리'), findsOneWidget);
      expect(find.text('학생 조회'), findsOneWidget);
    });

    testWidgets('교사는 교사 관리 메뉴를 보지 않는다', (tester) async {
      await pumpCategory(tester, 'TEACHER');

      expect(find.text('수업 기록'), findsOneWidget);
      expect(find.text('교사 관리'), findsNothing);
    });

    testWidgets('학생에게는 아카데미 메뉴를 보여주지 않는다', (tester) async {
      await pumpCategory(tester, 'STUDENT');

      expect(find.text('아카데미 메뉴'), findsNothing);
    });
  });
}
