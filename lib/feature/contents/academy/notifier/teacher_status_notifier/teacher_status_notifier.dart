import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../di/ApiProvider.dart';
import '../../data/api/teacher_status_api.dart';
import '../../data/repository/teacher_status_repository.dart';
import '../../domain/model/academy.dart';
import '../../domain/model/academy_class.dart';
import '../../domain/model/teacher.dart';
import '../../domain/model/teacher_status/teacher_status.dart';
import '../../domain/model/teacher_status_form.dart';
import '../../domain/type/teacher_status_type.dart';
import '../../state/teacher_status_state/teacher_status_state.dart';

part 'teacher_status_notifier.g.dart';

@riverpod
class TeacherStatusNotifier extends _$TeacherStatusNotifier {
  late final TeacherStatusRepository repository;

  @override
  TeacherStatusState build() {
    final TeacherStatusApi api = ref.read(
      teacherStatusApiProvider,
    );
    repository = TeacherStatusRepository(
      api: api,
    );
    _initialize();
    return const TeacherStatusState(
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
        teacherStatus: state.teacherStatus.copyWith(
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
      teacherStatus: state.teacherStatus.copyWith(
        selectedAcademy: academy,
        selectedAcademyClass: null,
        selectedTeacher: null,
        selectedStatusType: null,
        classes: [],
        teachers: [],
      ),
      errorMessage: null,
    );

    try {
      final List<AcademyClass> classes = await repository.getClasses(academy.id);
      state = state.copyWith(
        isLoading: false,
        teacherStatus: state.teacherStatus.copyWith(
          classes: classes,
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
    final int academyId = state.teacherStatus.selectedAcademy!.id;

    if (academyId == null) {
      return;
    }

    state = state.copyWith(
      isLoading: true,
      teacherStatus: state.teacherStatus.copyWith(
        selectedAcademyClass: academyClass,
        selectedTeacher: null,
        teachers: [],
      ),
      errorMessage: null,
    );

    try {
      final List<Teacher> teachers = await repository
          .getTeachers(
            academyId,
            academyClass.id,
          );
      state = state.copyWith(
        isLoading: false,
        teacherStatus: state.teacherStatus.copyWith(
          teachers: teachers,
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

  /// 교사 선택
  void selectTeacher(Teacher teacher) {
    state = state.copyWith(
      teacherStatus: state.teacherStatus.copyWith(
        selectedTeacher: teacher,
      ),
    );
  }

  /// 처리 상태 선택
  void selectStatus(
      TeacherStatusType status,
      ) {
    state = state.copyWith(
      teacherStatus: state.teacherStatus.copyWith(
        selectedStatusType: status,
        reason: '',
      ),
    );
  }

  /// 처리 사유 입력
  void setReason(
      String reason,
      ) {
    state = state.copyWith(
      teacherStatus: state.teacherStatus.copyWith(
        reason: reason,
      ),
    );
  }

  /// 학생 상태 처리
  Future<bool> process() async {
    if (!state.teacherStatus.isValid) {
      return false;
    }

    state = state.copyWith(
      isProcessing: true,
      errorMessage: null,
    );

    try {
      final TeacherStatus status = state.teacherStatus;

      final TeacherStatusForm form = TeacherStatusForm(
        academyName: status.selectedAcademy!.name,
        className: status.selectedAcademyClass!.classNumber,
        teacherDiscordId: status.selectedTeacher!.discordID,
        statusType: status.selectedStatusType!,
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
      teacherStatus: state.teacherStatus.copyWith(
        selectedAcademy: null,
        selectedAcademyClass: null,
        selectedTeacher: null,
        selectedStatusType: null,
        classes: [],
        teachers: [],
        reason: '',
      ),
      errorMessage: null,
    );
  }
}