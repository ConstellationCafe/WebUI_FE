import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:constellation_cafe/di/ApiProvider.dart';

import '../../data/api/student_status_api.dart';
import '../../data/repository/student_status_repository.dart';
import '../../domain/model/academy.dart';
import '../../domain/model/academy_class.dart';
import '../../domain/model/student.dart';
import '../../domain/type/student_roster_status.dart';
import '../../state/student_status_list_state/student_status_list_state.dart';

part 'student_status_list_notifier.g.dart';

@riverpod
class StudentStatusListNotifier extends _$StudentStatusListNotifier {
  late final StudentStatusRepository repository;

  @override
  StudentStatusListState build() {
    final StudentStatusApi api = ref.read(
      studentStatusApiProvider,
    );
    repository = StudentStatusRepository(
      api: api,
    );

    _loadAcademies();

    return const StudentStatusListState(
      isFilterLoading: true,
    );
  }

  Future<void> _loadAcademies() async {
    try {
      final List<Academy> academies = await repository.getAcademies();
      state = state.copyWith(
        isFilterLoading: false,
        query: state.query.copyWith(
          academies: academies,
        ),
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isFilterLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> selectAcademy(Academy? academy) async {
    if (academy == null) {
      state = state.copyWith(
        query: state.query.copyWith(
          selectedAcademy: null,
          selectedAcademyClass: null,
          selectedAcademyMember: null,
          classes: [],
          academyMembers: [],
          page: 1,
        ),
        errorMessage: null,
      );
      return;
    } else {
      state = state.copyWith(
        isFilterLoading: true,
        query: state.query.copyWith(
          selectedAcademy: academy,
          selectedAcademyClass: null,
          selectedAcademyMember: null,
          classes: [],
          academyMembers: [],
          page: 1,
        ),
        errorMessage: null,
      );
    }
    try {
      final List<AcademyClass> classes = await repository.getClasses(
        academy.id,
      );
      state = state.copyWith(
        isFilterLoading: false,
        query: state.query.copyWith(
          classes: classes,
        ),
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isFilterLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> selectClass(AcademyClass? academyClass) async {
    if (academyClass == null) {
      state = state.copyWith(
        query: state.query.copyWith(
          selectedAcademyClass: null,
          selectedAcademyMember: null,
          academyMembers: [],
          page: 1,
        ),
        errorMessage: null,
      );
      return;
    }

    final Academy? academy = state.query.selectedAcademy;
    if (academy == null) {
      return;
    }
    state = state.copyWith(
      isFilterLoading: true,
      query: state.query.copyWith(
        selectedAcademyClass: academyClass,
        selectedAcademyMember: null,
        academyMembers: [],
        page: 1,
      ),
      errorMessage: null,
    );

    try {
      final List<Student> students = await repository.getStudents(
        academy.id,
        academyClass.id,
      );
      state = state.copyWith(
        isFilterLoading: false,
        query: state.query.copyWith(
          academyMembers: students,
        ),
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isFilterLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void selectStudent(Student? student) {
    state = state.copyWith(
      query: state.query.copyWith(
        selectedAcademyMember: student,
        page: 1,
      ),
      errorMessage: null,
    );
  }

  void selectStatus(StudentRosterStatus? status) {
    state = state.copyWith(
      query: state.query.copyWith(
        selectedStatus: status,
        page: 1,
      ),
      errorMessage: null,
    );
  }

  Future<void> search() async {
    await _loadStudentStatuses(
      page: 1,
    );
  }

  Future<void> changePage(int page) async {
    if (page < 1 ||
        page > state
                .studentStatusList
                .totalPages) {
      return;
    }
    await _loadStudentStatuses(
      page: page,
    );
  }

  Future<void> _loadStudentStatuses({ required int page }) async {
    state = state.copyWith(
      isLoading: true,
      query: state.query.copyWith(
        page: page,
      ),
      errorMessage: null,
    );
    try {
      final result = await repository.getStudentStatuses(
        academyId: state.query.selectedAcademy
                    ?.id,
        classId: state.query.selectedAcademyClass
                    ?.id,
        academyMemberId: state.query.selectedAcademyMember
                    ?.sk,
        status: state.query.selectedStatus,
        page: page,
        size: state.query.pageSize,
      );
      state = state.copyWith(
        isLoading: false,
        studentStatusList: result,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> resetFilters() async {
    state = state.copyWith(
      query: state.query.copyWith(
        selectedAcademy: null,
        selectedAcademyClass: null,
        selectedAcademyMember: null,
        selectedStatus: null,
        classes: [],
        academyMembers: [],
        page: 1,
      ),
      errorMessage: null,
    );
  }
}