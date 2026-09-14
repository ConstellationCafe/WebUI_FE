import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:constellation_cafe/di/ApiProvider.dart';

import '../../data/api/teacher_status_api.dart';
import '../../data/repository/teacher_status_repository.dart';

import '../../domain/model/academy.dart';
import '../../domain/model/academy_class.dart';
import '../../domain/model/teacher.dart';

import '../../domain/type/teacher_roster_status.dart';

import '../../state/teacher_status_list_state/teacher_status_list_state.dart';

part 'teacher_status_list_notifier.g.dart';

@riverpod
class TeacherStatusListNotifier
    extends _$TeacherStatusListNotifier {
  late final TeacherStatusRepository repository;

  @override
  TeacherStatusListState build() {
    final TeacherStatusApi api = ref.read(
      teacherStatusApiProvider,
    );

    repository = TeacherStatusRepository(
      api: api,
    );

    _loadAcademies();

    return const TeacherStatusListState(
      isFilterLoading: true,
    );
  }

  Future<void> _loadAcademies() async {
    try {
      final List<Academy> academies =
      await repository.getAcademies();

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

  Future<void> selectAcademy(
      Academy? academy,
      ) async {
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
    }

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

    try {
      final List<AcademyClass> classes =
      await repository.getClasses(
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

  Future<void> selectClass(
      AcademyClass? academyClass,
      ) async {
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

    final Academy? academy =
        state.query.selectedAcademy;

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
      final List<Teacher> teachers =
      await repository.getTeachers(
        academy.id,
        academyClass.id,
      );

      state = state.copyWith(
        isFilterLoading: false,
        query: state.query.copyWith(
          academyMembers: teachers,
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

  void selectTeacher(
      Teacher? teacher,
      ) {
    state = state.copyWith(
      query: state.query.copyWith(
        selectedAcademyMember: teacher,
        page: 1,
      ),
      errorMessage: null,
    );
  }

  void selectStatus(
      TeacherRosterStatus? status,
      ) {
    state = state.copyWith(
      query: state.query.copyWith(
        selectedStatus: status,
        page: 1,
      ),
      errorMessage: null,
    );
  }

  Future<void> search() async {
    await _loadTeacherStatuses(
      page: 1,
    );
  }

  Future<void> changePage(
      int page,
      ) async {
    if (page < 1 ||
        page >
            state
                .teacherStatusList
                .totalPages) {
      return;
    }

    await _loadTeacherStatuses(
      page: page,
    );
  }

  Future<void> _loadTeacherStatuses({
    required int page,
  }) async {
    state = state.copyWith(
      isLoading: true,
      query: state.query.copyWith(
        page: page,
      ),
      errorMessage: null,
    );

    try {
      final result =
      await repository.getTeacherStatuses(
        academyId:
        state.query
            .selectedAcademy
            ?.id,
        classId:
        state.query
            .selectedAcademyClass
            ?.id,
        academyMemberId:
        state.query
            .selectedAcademyMember
            ?.sk,
        status:
        state.query.selectedStatus,
        page: page,
        size: state.query.pageSize,
      );

      state = state.copyWith(
        isLoading: false,
        teacherStatusList: result,
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