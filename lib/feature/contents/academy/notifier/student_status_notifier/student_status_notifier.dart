import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../di/ApiProvider.dart';
import '../../data/api/student_status_api.dart';
import '../../domain/model/academy.dart';
import '../../domain/model/academy_class.dart';
import '../../domain/model/student.dart';
import '../../domain/model/student_status_form.dart';
import '../../domain/model/subject.dart';
import '../../domain/type/student_status_type.dart';
import '../../state/student_status_state/student_status_state.dart';

part 'student_status_notifier.g.dart';

@riverpod
class StudentStatusNotifier
    extends _$StudentStatusNotifier {
  late final StudentStatusApi _api;

  @override
  StudentStatusState build() {
    _api = ref.watch(
      studentStatusApiProvider,
    );

    Future.microtask(_initialize);

    return const StudentStatusState(
      isLoading: true,
    );
  }

  /// 최초 진입 시 학원 목록 조회
  Future<void> _initialize() async {
    try {
      final response = await _api.getOptions();

      state = state.copyWith(
        isLoading: false,
        academies: response.academies
            .map(
              (academy) => Academy(
            id: academy.id,
            name: academy.name,
          ),
        )
            .toList(),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// 학원 선택
  Future<void> selectAcademy(String academyId) async {
    state = state.copyWith(
      selectedAcademyId: academyId,
      selectedClassName: null,
      selectedStudentId: null,
      selectedStatusType: null,
      selectedSubjectIds: [],
      classes: [],
      students: [],
      subjects: [],
      isLoading: true,
      errorMessage: null,
    );
    try {
      final response = await _api.getOptions(
        academyId: academyId,
      );
      state = state.copyWith(
        isLoading: false,
        classes: response.classes
            .map(
              (academyClass) => AcademyClass(
                id: academyClass.id,
                classNumber: academyClass.classNumber,
                state: academyClass.state,
              ),
            )
            .toList(),
        subjects: response.subjects
            .map(
              (subject) => Subject(
                id: subject.id,
                name: subject.name,
              ),
            )
            .toList(),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// 분반 선택
  Future<void> selectClass(
      String className,
      ) async {
    final academyId = state.selectedAcademyId;

    if (academyId == null) {
      return;
    }

    state = state.copyWith(
      selectedClassName: className,
      selectedStudentId: null,
      isLoading: true,
      errorMessage: null,
      students: [],
    );

    try {
      final response = await _api.getOptions(
        academyId: academyId,
        className: className,
      );

      state = state.copyWith(
        isLoading: false,
        students: response.students
            .map(
              (student) => AcademyStudent(
            id: student.id,
            name: student.name,
          ),
        )
            .toList(),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// 학생 선택
  void selectStudent(
      String studentId,
      ) {
    state = state.copyWith(
      selectedStudentId: studentId,
    );
  }

  /// 처리 상태 선택
  void selectStatus(
      StudentStatusType status,
      ) {
    state = state.copyWith(
      selectedStatusType: status,
      selectedSubjectIds: [],
      reason: '',
    );
  }

  /// 졸업 대상 교과목 선택/해제
  void toggleSubject(
      String subjectId,
      ) {
    if (state.selectedStatusType !=
        StudentStatusType.graduation) {
      return;
    }

    final selectedSubjectIds = [
      ...state.selectedSubjectIds,
    ];

    if (selectedSubjectIds.contains(subjectId)) {
      selectedSubjectIds.remove(subjectId);
    } else {
      selectedSubjectIds.add(subjectId);
    }

    state = state.copyWith(
      selectedSubjectIds: selectedSubjectIds,
    );
  }

  /// 처리 사유 입력
  void setReason(
      String reason,
      ) {
    state = state.copyWith(
      reason: reason,
    );
  }

  /// 학생 상태 처리
  Future<bool> process() async {
    if (!_validate()) {
      return false;
    }
    state = state.copyWith(
      isProcessing: true,
      errorMessage: null,
    );
    try {
      final statusType = state.selectedStatusType!;
      final form = StudentStatusForm(
        // 학생 지정
        academyId: state.selectedAcademyId!,
        className: state.selectedClassName!,
        studentId: state.selectedStudentId!,
        // 졸업 / 자퇴 / 퇴학
        statusType: statusType,
        // 학생 졸업 처리시엔 과목 선택란 추가
        subjectIds: statusType == StudentStatusType.graduation
                    ? state.selectedSubjectIds
                    : const [],
        // 자퇴 / 퇴학 사유
        reason: state.reason.trim(),
      );
      await _api.process(form);
      state = state.copyWith(
        isProcessing: false,
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

  bool _validate() {
    if (state.selectedAcademyId == null) {
      return false;
    }

    if (state.selectedClassName == null) {
      return false;
    }

    if (state.selectedStudentId == null) {
      return false;
    }

    if (state.selectedStatusType == null) {
      return false;
    }

    return true;
  }

  /// 입력값 초기화
  void reset() {
    state = state.copyWith(
      selectedAcademyId: null,
      selectedClassName: null,
      selectedStudentId: null,
      selectedStatusType: null,
      selectedSubjectIds: [],
      classes: [],
      students: [],
      subjects: [],
      reason: '',
      errorMessage: null,
    );
  }
}