import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/modules/academy/data/api/academy_api.dart';
import 'package:constellation_cafe/feature/modules/academy/data/api/lesson_record_api.dart';
import 'package:constellation_cafe/feature/modules/academy/data/api/student_status_api.dart';
import 'package:constellation_cafe/feature/modules/academy/data/api/teacher_status_api.dart';
import 'package:constellation_cafe/feature/modules/academy/data/dto/request/lesson_record_query_request.dart';
import 'package:constellation_cafe/feature/modules/academy/data/dto/request/status_query_request.dart';
import 'package:constellation_cafe/feature/modules/academy/data/repository/student_status_repository.dart';
import 'package:constellation_cafe/feature/modules/academy/data/repository/teacher_status_repository.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/lesson_record/lesson_record.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/lesson_record/lesson_record_update.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/student_status/student_status.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/student_status/student_status_form.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/teacher_status/teacher_status_form.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/type/student_roster_status.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/type/student_status_type.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/type/teacher_roster_status.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/type/teacher_status_type.dart';
import 'package:constellation_cafe/feature/modules/academy/notifier/lesson_record_selection_notifier/lesson_record_selection_notifier.dart';
import 'package:constellation_cafe/feature/modules/academy/notifier/permission_notifier/academy_permission_notifier.dart';
import 'package:constellation_cafe/feature/modules/academy/notifier/student_status_notifier/student_status_notifier.dart';

import 'package:constellation_cafe/test/support/fake_backend.dart';
import 'package:constellation_cafe/test/support/fake_translator.dart';
import 'package:constellation_cafe/test/support/feature/modules/academy/support/academy_fixtures.dart';

void main() {
  late FakeBackend backend;

  setUp(() => backend = FakeBackend());
  tearDown(() => backend.close());

  group('AcademyApi', () {
    test('내 권한을 역할과 분반 단위로 해석한다', () async {
      backend.reply(
        'GET',
        '/api/academy/me/permissions',
        ok(permissionJson(classIds: [2])),
      );

      final permission = await AcademyApi(dio: backend.dio).getMyPermissions();

      expect(permission.isAdmin, isFalse);
      expect(permission.isTeacherOrAbove(), isTrue);
      expect(permission.isOwner(), isFalse);
      expect(permission.isTeacherOrAboveWithClass(1, 2), isTrue);
      expect(permission.isTeacherOrAboveWithClass(1, 3), isFalse);
      expect(permission.isTeacherOrAboveWithAcademy(9), isFalse);
    });

    test('학원 하위 자원은 학원과 분반 ID를 경로에 담아 조회한다', () async {
      final api = AcademyApi(dio: backend.dio);
      backend.reply('GET', '/api/academy', ok([academyJson()]));
      backend.reply('GET', '/api/academy/1/classes', ok([classJson(3)]));
      backend.reply('GET', '/api/academy/1/subjects', ok([subjectJson()]));
      final teachers = [memberJson('t1', '박해')];
      final students = [memberJson('s1', '김별')];
      backend.reply('GET', '/api/academy/teachers/1/classes/3', ok(teachers));
      backend.reply('GET', '/api/academy/students/1/classes/3', ok(students));

      expect((await api.getAcademies()).single.name, '별빛 아카데미');
      expect((await api.getClasses(1)).single.classNumber, '3');
      expect((await api.getSubjects(1)).single.name, '덱 빌딩');
      expect((await api.getTeachers(1, 3)).single.discordID, 'dt1');
      expect((await api.getStudents(1, 3)).single.name, '김별');
    });
  });

  group('LessonRecordApi', () {
    late LessonRecordApi api;

    setUp(() => api = LessonRecordApi(dio: backend.dio));

    test('조회 조건 중 값이 있는 항목만 날짜 형식에 맞춰 보낸다', () async {
      backend.reply('GET', '/api/academy/lesson-records', [lessonRecordJson()]);

      final records = await api.getLessonRecords(
        LessonRecordQueryRequest(academyId: 1, date: DateTime(2026, 9, 7)),
      );

      expect(backend.last.queryParameters, {
        'academyId': 1,
        'date': '2026-09-07',
      });
      final record = records.single;
      expect(record.id, '10');
      expect(record.subjectName, '덱 빌딩');
      expect(record.startTime?.hour, 19);
      expect(record.endTime?.minute, 30);
      expect(record.educationDuration, const Duration(minutes: 90));
      expect(record.canModify, isTrue);
    });

    test('목록이 아닌 응답은 형식 오류로 처리한다', () async {
      backend.reply('GET', '/api/academy/lesson-records', ok([]));

      await expectLater(
        api.getLessonRecords(const LessonRecordQueryRequest()),
        throwsA(isA<Exception>()),
      );
    });

    test('수업 기록 생성은 시간을 HH:mm:ss, 수업 길이를 분으로 보낸다', () async {
      backend.reply('POST', '/api/academy/lesson-record', null);
      final record = LessonRecord(
        academyId: 1,
        className: '1',
        subjectName: '덱 빌딩',
        educationDate: DateTime(2026, 9, 27),
        startTime: DateTime(2026, 9, 27, 19),
        endTime: DateTime(2026, 9, 27, 20, 30),
        educationDuration: const Duration(minutes: 90),
        mainTeacherId: 't1',
        coTeacherIds: const ['t2'],
        memberIds: const ['s1', 's2'],
        description: '실전 연습',
      );

      await api.createLessonRecord(record);

      final body = backend.last.data as Map<String, dynamic>;
      expect(body['subject'], '덱 빌딩');
      expect(body['startTime'], '19:00:00');
      expect(body['endTime'], '20:30:00');
      expect(body['educationDuration'], 90);
      expect(body['memberIds'], ['s1', 's2']);
    });

    test('수정과 삭제는 기록 ID 경로를 사용한다', () async {
      backend.reply('PUT', '/api/academy/lesson-record/10', null);
      backend.reply('DELETE', '/api/academy/lesson-record/10', null);
      final update = LessonRecordUpdate(
        subject: '덱 빌딩',
        educationDate: DateTime(2026, 9, 27, 23),
        startTime: DateTime(2026, 9, 27, 19),
        endTime: DateTime(2026, 9, 27, 21),
        description: '수정',
      );

      await api.updateLessonRecord('10', update);
      final body = backend.last.data as Map<String, dynamic>;
      await api.deleteLessonRecord('10');

      expect(body['educationDuration'], 120);
      expect(body['educationDate'], startsWith('2026-09-27T00:00:00'));
      final methods = backend.requests.map((request) => request.method);
      expect(methods, ['PUT', 'DELETE']);
    });
  });

  group('학생·교사 상태 API', () {
    test('학생 상태 목록은 필터를 쿼리로 보내고 요약과 페이지를 읽는다', () async {
      backend.reply('GET', '/api/academy/students', ok(studentStatusPage()));
      final translator = FakeTranslator();
      final api = StudentStatusApi(translator: translator, dio: backend.dio);
      final repository = StudentStatusRepository(api: api);

      final result = await repository.getStudentStatuses(
        academyId: 1,
        status: StudentRosterStatus.graduation,
      );

      expect(backend.last.queryParameters, {
        'academyId': 1,
        'status': 'GRADUATED',
        'page': 1,
        'size': 20,
      });
      expect(result.items.first.status, StudentRosterStatus.graduation);
      expect(result.items.first.reason, '과정 수료');
      expect(result.graduationCount, 1);
      expect(result.totalPages, 1);
    });

    test('교사 상태 목록은 징계 상태와 현재 페이지를 읽는다', () async {
      backend.reply('GET', '/api/academy/teachers', ok(teacherStatusPage()));
      final translator = FakeTranslator();
      final api = TeacherStatusApi(translator: translator, dio: backend.dio);
      final repository = TeacherStatusRepository(api: api);

      final result = await repository.getTeacherStatuses(page: 2);

      expect(backend.last.queryParameters, {'page': 2, 'size': 20});
      expect(result.items.single.status, TeacherRosterStatus.disciplinary);
      expect(result.currentPage, 2);
      expect(result.totalPages, 3);
    });

    test('빈 멤버 ID는 쿼리에서 제외한다', () {
      const request = StatusQueryRequest<StudentRosterStatus>(
        academyMemberId: '',
        page: 3,
      );

      expect(request.toJson(), {'page': 3, 'size': 20});
    });

    test('알 수 없는 상태 값은 명확한 오류로 거부한다', () {
      expect(
        () => StudentRosterStatus.fromApiValue('UNKNOWN'),
        throwsArgumentError,
      );
      expect(() => TeacherStatusType.fromApiValue('X'), throwsArgumentError);
    });

    test('학생 처리 유형별로 봇 명령과 인자를 고른다', () async {
      final translator = FakeTranslator();
      final api = StudentStatusApi(translator: translator, dio: backend.dio);
      const graduation = StudentStatusForm(
        academyName: '별빛 아카데미',
        className: '1',
        studentDiscordId: 'd1',
        statusType: StudentStatusType.graduation,
        subjectNames: ['덱 빌딩'],
        reason: '수료',
      );
      const withdrawal = StudentStatusForm(
        academyName: '별빛 아카데미',
        className: '1',
        studentDiscordId: 'd1',
        statusType: StudentStatusType.withdrawal,
        reason: '개인 사정',
      );

      await api.process(graduation);
      await api.process(withdrawal);

      expect(translator.calls.first.$1, endsWith('/graduate_approve'));
      expect(translator.calls.first.$2, [
        'd1',
        '별빛 아카데미',
        '1',
        ['덱 빌딩'],
        '수료',
      ]);
      expect(translator.calls.last.$1, endsWith('/suspended_command'));
      expect(translator.calls.last.$2, ['d1', '개인 사정']);
    });

    test('교사 퇴직은 retire_teacher 명령을 사용한다', () async {
      final translator = FakeTranslator();
      final api = TeacherStatusApi(translator: translator, dio: backend.dio);

      await api.process(
        const TeacherStatusForm(
          academyName: '별빛 아카데미',
          className: '1',
          teacherDiscordId: 'dt1',
          statusType: TeacherStatusType.retire,
        ),
      );

      expect(translator.calls.single.$1, endsWith('/retire_teacher'));
      expect(translator.calls.single.$2, ['dt1', '별빛 아카데미', '1']);
    });
  });

  group('권한에 따른 선택지', () {
    late FakeTranslator translator;
    late ProviderContainer container;

    Future<void> signIn(Map<String, dynamic> permission) async {
      backend.reply('GET', '/api/academy/me/permissions', ok(permission));
      await container.read(academyPermissionProvider.notifier).initialize();
    }

    setUp(() {
      translator = FakeTranslator();
      container = ProviderContainer(
        overrides: [
          academyApiProvider.overrideWithValue(AcademyApi(dio: backend.dio)),
          lessonRecordApiProvider.overrideWithValue(
            LessonRecordApi(dio: backend.dio),
          ),
          studentStatusApiProvider.overrideWithValue(
            StudentStatusApi(translator: translator, dio: backend.dio),
          ),
        ],
      );
      final user = container.read(currentUserStateProvider.notifier);
      user.update(userId: 'dt1');
    });

    tearDown(() => container.dispose());

    test('교사는 담당 학원·운영 분반·본인만 수업 기록 주강사로 고를 수 있다', () async {
      await signIn(permissionJson(classIds: [1]));
      final academies = [academyJson(), academyJson(id: 2, name: '달빛')];
      final classes = [classJson(1), classJson(2), classJson(3, state: '종료')];
      final teachers = [
        memberJson('t1', '박해'),
        memberJson('t2', '최달'),
        memberJson('t3', '정휴', state: '은퇴'),
      ];
      backend.reply('GET', '/api/academy', ok(academies));
      backend.reply('GET', '/api/academy/1/classes', ok(classes));
      backend.reply('GET', '/api/academy/1/subjects', ok([]));
      backend.reply('GET', '/api/academy/teachers/1/classes/1', ok(teachers));
      backend.reply('GET', '/api/academy/students/1/classes/1', ok([]));
      container.listen(lessonRecordSelectionProvider, (_, _) {});
      final notifier = container.read(lessonRecordSelectionProvider.notifier);
      await pumpEventQueue();

      final form = container.read(lessonRecordSelectionProvider).queryForm;
      expect(form.academies.map((academy) => academy.id), [1]);

      await notifier.selectAcademy(form.academies.single);
      final classesForm = container.read(lessonRecordSelectionProvider);
      expect(classesForm.queryForm.classes.map((c) => c.id), [1]);

      await notifier.selectClass(classesForm.queryForm.classes.single);
      final selection = container.read(lessonRecordSelectionProvider);
      expect(selection.queryForm.teachers.map((t) => t.sk), ['t1']);
      expect(selection.queryForm.coTeachers.map((t) => t.sk), ['t1', 't2']);
    });

    test('학생 졸업 처리는 선택한 교과목과 사유를 담아 봇에 요청한다', () async {
      await signIn(permissionJson(role: 'ACADEMY_OWNER'));
      backend.reply(
        'GET',
        '/api/academy/students/options',
        ok(studentOptions()),
      );
      container.listen(studentStatusProvider, (_, _) {});
      final notifier = container.read(studentStatusProvider.notifier);
      await pumpEventQueue();

      StudentStatus current() {
        return container.read(studentStatusProvider).studentStatus;
      }

      await notifier.selectAcademy(current().academies.single);
      await notifier.selectClass(current().classes.single);
      notifier.selectStudent(current().students.single);
      notifier.selectStatus(StudentStatusType.graduation);
      notifier.toggleSubject(current().subjects.single);
      notifier.setReason(' 수료 ');

      expect(await notifier.process(), isTrue);
      expect(translator.calls.single.$2, [
        'ds1',
        '별빛 아카데미',
        '1',
        ['덱 빌딩'],
        '수료',
      ]);
    });

    test('필수 선택이 비어 있으면 처리 요청을 보내지 않는다', () async {
      await signIn(permissionJson(role: 'ACADEMY_OWNER'));
      backend.reply(
        'GET',
        '/api/academy/students/options',
        ok(studentOptions()),
      );
      container.listen(studentStatusProvider, (_, _) {});
      final notifier = container.read(studentStatusProvider.notifier);
      await pumpEventQueue();

      notifier.selectStatus(StudentStatusType.expulsion);

      expect(await notifier.process(), isFalse);
      expect(translator.calls, isEmpty);
    });
  });
}
