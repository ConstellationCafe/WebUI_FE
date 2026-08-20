import 'package:constellation_cafe/feature/contents/academy/data/dto/request/lesson_record_query_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:constellation_cafe/di/ApiProvider.dart';

import '../../data/api/academy_api.dart';
import '../../data/api/lesson_record_api.dart';
import '../../state/lesson_record_list_state/lesson_record_list_state.dart';

part 'lesson_record_list_notifier.g.dart';

@riverpod
class LessonRecordListNotifier extends _$LessonRecordListNotifier {
  late final LessonRecordApi _lessonRecordApi;
  late final AcademyApi _academyApi;

  @override
  LessonRecordListState build() {
    _lessonRecordApi = ref.watch(lessonRecordApiProvider);
    _academyApi = ref.watch(academyApiProvider);
    return LessonRecordListState(
      isLoading: true,
    );
  }

  Future<void> selectAcademy(String? academyId) async {
    if (academyId == null) {
      state = state.copyWith(
        lessonRecordList: state.lessonRecordList.copyWith(
          selectedAcademyId: null,
          selectedClassId: null,
          selectedSubjectId: null,
          classes: [],
          subjects: [],
        )
      );
      return;
    }

    state = state.copyWith(
      selectedAcademyId: academyId,
      selectedClassId: null,
      selectedSubjectId: null,
      classes: [],
      subjects: [],
      isFilterLoading: true,
    );

    try {
      final classes =
      await _academyApi.getClasses(academyId);

      final subjects =
      await _academyApi.getSubjects(academyId);

      state = state.copyWith(
        isFilterLoading: false,
        classes: classes,
        subjects: subjects,
      );
    } catch (e) {
      state = state.copyWith(
        isFilterLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void selectClass(
      String? classId,
      ) {
    state = state.copyWith(
      selectedClassId: classId,
    );
  }

  void selectSubject(
      String? subjectId,
      ) {
    state = state.copyWith(
      selectedSubjectId: subjectId,
    );
  }

  void setDate(
      DateTime? date,
      ) {
    state = state.copyWith(
      selectedDate: date,
    );
  }

  void setTime(
      String? time,
      ) {
    state = state.copyWith(
      selectedTime: time,
    );
  }

  void setTeacher(
      String? teacherId,
      ) {
    state = state.copyWith(
      selectedTeacherId: teacherId,
    );
  }

  Future<void> search() async {
    await loadRecords();
  }

  Future<void> loadRecords() async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      final records = await _lessonRecordApi.getLessonRecords(
        LessonRecordQueryRequest(
          academyId: state.selectedAcademyId,
          classId: state.selectedClassId,
          date: state.selectedDate,
          time: state.selectedTime,
          subject: state.selectedSubjectId,
          teacherId: state.selectedTeacherId,
        ),
      );
      // final records =
      // await _lessonRecordApi.getLessonRecords(
      //   academyId: state.selectedAcademyId,
      //   classId: state.selectedClassId,
      //   date: state.selectedDate,
      //   time: state.selectedTime,
      //   subject: state.selectedSubjectId,
      //   teacherId: state.selectedTeacherId,
      // );

      state = state.copyWith(
        isLoading: false,
        records: records,
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
      selectedAcademyId: null,
      selectedClassId: null,
      selectedSubjectId: null,
      selectedDate: null,
      selectedTime: null,
      selectedTeacherId: null,
      classes: [],
      subjects: [],
    );

    await loadRecords();
  }
}