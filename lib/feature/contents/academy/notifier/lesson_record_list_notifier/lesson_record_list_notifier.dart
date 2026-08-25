import 'package:constellation_cafe/di/ApiProvider.dart';
import 'package:constellation_cafe/feature/contents/academy/domain/model/lesson_record_selection/lesson_record_selection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repository/lesson_record_repository.dart';
import '../../domain/model/lesson_record_view.dart';
import '../../state/lesson_record_list_state/lesson_record_list_state.dart';
import '../../state/lesson_record_selection_state/lesson_record_selection_state.dart';
import '../lesson_record_selection_notifier/lesson_record_selection_notifier.dart';

part 'lesson_record_list_notifier.g.dart';

@riverpod
class LessonRecordListNotifier
    extends _$LessonRecordListNotifier {
  late final LessonRecordRepository _repository;

  @override
  LessonRecordListState build() {
    _repository = LessonRecordRepository(
      academyApi: ref.read(academyApiProvider),
      lessonRecordApi: ref.read(lessonRecordApiProvider),
    );

    return LessonRecordListState(
      isLoading: false,
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

    final LessonRecordSelectionState lessonRecordSelectionState =
    ref.read(lessonRecordSelectionProvider);

    final LessonRecordSelection lessonRecordSelection =
        lessonRecordSelectionState.queryForm;

    try {
      final records = await _repository.getLessonRecords(
        academyId: lessonRecordSelection.selectedAcademy?.id,
        classId: lessonRecordSelection.selectedAcademyClass?.id,
        date: lessonRecordSelection.educationDate,
        time: lessonRecordSelection.startTime,
        subject: lessonRecordSelection.selectedSubject?.name,
        teacherId: lessonRecordSelection.mainTeacher?.sk,
      );

      state = state.copyWith(
        isLoading: false,
        lessonRecordList: state.lessonRecordList.copyWith(
          records: records.map((record) {
              return LessonRecordView(
                id: record.id,
                academyName: record.academyName,
                className: record.className,
                subjectName: record.subjectName,
                educationDate: record.educationDate,
                educationDuration: record.educationDuration,
                mainTeacherName: record.mainTeacherName,
                description: record.description,
                memberCount: record.memberCount,
              );
            },
          ).toList(),
        ),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
}