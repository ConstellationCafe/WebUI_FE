import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:constellation_cafe/di/ApiProvider.dart';
import '../api/lesson_record_api.dart';
import '../state/lesson_record_list_state.dart';

part 'lesson_record_list_notifier.g.dart';

@riverpod
class LessonRecordListNotifier
    extends _$LessonRecordListNotifier {
  late final LessonRecordApi _api;

  @override
  LessonRecordListState build() {
    _api = ref.watch(lessonRecordApiProvider);

    Future.microtask(loadRecords);

    return const LessonRecordListState(
      isLoading: true,
    );
  }

  Future<void> loadRecords() async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );
    try {
      final records = await _api.getLessonRecords(
        date: state.selectedDate,
        time: state.selectedTime,
        subject: state.selectedSubject,
        // 현재는 null.
        // 추후 관리자 화면에서 teacherId를 지정하면
        // 해당 교사의 수업 기록 조회가 가능하다.
        teacherId: state.selectedTeacherId,
      );
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

  void setDate(DateTime? date) {
    state = state.copyWith(
      selectedDate: date,
    );
  }

  void setTime(String? time) {
    state = state.copyWith(
      selectedTime: time,
    );
  }

  void setSubject(String? subject) {
    state = state.copyWith(
      selectedSubject: subject,
    );
  }

  /// 추후 관리자 기능에서 사용
  void setTeacher(String? teacherId) {
    state = state.copyWith(
      selectedTeacherId: teacherId,
    );
  }

  Future<void> search() async {
    await loadRecords();
  }

  Future<void> resetFilters() async {
    state = state.copyWith(
      selectedDate: null,
      selectedTime: null,
      selectedSubject: null,
      selectedTeacherId: null,
    );

    await loadRecords();
  }
}