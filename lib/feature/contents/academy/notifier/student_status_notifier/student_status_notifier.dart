import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../di/ApiProvider.dart';
import '../../data/api/student_status_api.dart';
import '../../data/repository/student_status_repository.dart';
import '../../domain/model/academy.dart';
import '../../domain/model/academy_class.dart';
import '../../domain/model/student.dart';
import '../../domain/model/student_status/student_status.dart';
import '../../domain/model/student_status_form.dart';
import '../../domain/model/subject.dart';
import '../../domain/type/student_status_type.dart';
import '../../state/student_status_state/student_status_state.dart';

part 'student_status_notifier.g.dart';

@riverpod
class StudentStatusNotifier extends _$StudentStatusNotifier {
  late final StudentStatusRepository repository;

  @override
  StudentStatusState build() {
    final StudentStatusApi api = ref.read(
      studentStatusApiProvider,
    );
    repository = StudentStatusRepository(
      api: api,
    );
    _initialize();
    return const StudentStatusState(
      isLoading: false,
    );
  }

  /// 최초 진입 시 학원 목록 조회
  Future<void> _initialize() async {
    try {
      final List<Academy> academies =
      await repository.getAcademies();

      state = state.copyWith(
        isLoading: false,
        studentStatus: state.studentStatus.copyWith(
          academies: academies,
        ),
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// 학원 선택
  Future<void> selectAcademy(Academy academy) async {
    state = state.copyWith(
      isLoading: true,
      studentStatus: state.studentStatus.copyWith(
        selectedAcademy: academy,
        selectedAcademyClass: null,
        selectedStudent: null,
        selectedStatusType: null,
        selectedSubjects: [],
        classes: [],
        students: [],
        subjects: [],
      ),
      errorMessage: null,
    );

    try {
      final List<AcademyClass> classes = await repository.getClasses(academy.id);
      final List<Subject> subjects = await repository.getSubjects(academy.id);
      state = state.copyWith(
        isLoading: false,
        studentStatus: state.studentStatus.copyWith(
          classes: classes,
          subjects: subjects,
        ),
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// 분반 선택
  Future<void> selectClass(AcademyClass academyClass) async {
    final int academyId = state.studentStatus.selectedAcademy!.id;

    if (academyId == null) {
      return;
    }

    state = state.copyWith(
      isLoading: true,
      studentStatus: state.studentStatus.copyWith(
        selectedAcademyClass: academyClass,
        selectedStudent: null,
        students: [],
      ),
      errorMessage: null,
    );

    try {
      final List<Student> students = await repository
          .getStudents(
            academyId,
            academyClass.id,
          );
      state = state.copyWith(
        isLoading: false,
        studentStatus: state.studentStatus.copyWith(
          students: students,
        ),
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// 학생 선택
  void selectStudent(Student student) {
    state = state.copyWith(
      studentStatus: state.studentStatus.copyWith(
        selectedStudent: student,
      ),
    );
  }

  /// 처리 상태 선택
  void selectStatus(
      StudentStatusType status,
      ) {
    state = state.copyWith(
      studentStatus: state.studentStatus.copyWith(
        selectedStatusType: status,
        selectedSubjects: [],
        reason: '',
      ),
    );
  }

  /// 졸업 대상 교과목 선택/해제
  void toggleSubject(Subject subject) {
    if (state.studentStatus.selectedStatusType !=
        StudentStatusType.graduation) {
      return;
    }

    final selectedSubjects = [
      ...state.studentStatus.selectedSubjects,
    ];

    if (selectedSubjects.contains(subject)) {
      selectedSubjects.remove(subject);
    } else {
      selectedSubjects.add(subject);
    }

    state = state.copyWith(
      studentStatus: state.studentStatus.copyWith(
        selectedSubjects: selectedSubjects,
      ),
    );
  }

  /// 처리 사유 입력
  void setReason(
      String reason,
      ) {
    state = state.copyWith(
      studentStatus: state.studentStatus.copyWith(
        reason: reason,
      ),
    );
  }

  /// 학생 상태 처리
  Future<bool> process() async {
    if (!state.studentStatus.isValid) {
      return false;
    }

    state = state.copyWith(
      isProcessing: true,
      errorMessage: null,
    );

    try {
      final StudentStatus status = state.studentStatus;

      final StudentStatusForm form = StudentStatusForm(
        academyName: status.selectedAcademy!.name,
        className: status.selectedAcademyClass!.classNumber,
        studentDiscordId: status.selectedStudent!.discordID,
        statusType: status.selectedStatusType!,
        subjectIds: status.selectedStatusType == StudentStatusType.graduation
            ? status.selectedSubjects.map(
                (subject) => subject.id
            ).toList()
            : const [],
        reason: status.reason.trim(),
      );

      await repository.process(form);

      state = state.copyWith(
        isProcessing: false,
        errorMessage: null,
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        errorMessage: e.toString(),
      );

      return false;
    }
  }

  /// 입력값 초기화
  void reset() {
    state = state.copyWith(
      studentStatus: state.studentStatus.copyWith(
        selectedAcademy: null,
        selectedAcademyClass: null,
        selectedStudent: null,
        selectedStatusType: null,
        selectedSubjects: [],
        classes: [],
        students: [],
        subjects: [],
        reason: '',
      ),
      errorMessage: null,
    );
  }
}