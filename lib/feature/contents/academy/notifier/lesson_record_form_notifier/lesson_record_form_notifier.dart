import 'package:constellation_cafe/di/ApiProvider.dart';
import 'package:constellation_cafe/feature/contents/academy/notifier/lesson_record_query_notifier/lesson_record_query_notifier.dart';
import 'package:constellation_cafe/feature/contents/academy/state/lesson_record_query_state/lesson_record_query_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repository/lesson_record_repository.dart';
import '../../domain/model/lesson_record.dart';
import '../../domain/model/lesson_record_form/lesson_record_form.dart';
import '../../domain/model/lesson_record_query/lesson_record_query.dart';
import '../../state/lesson_record_form_state/lesson_record_form_state.dart';

part 'lesson_record_form_notifier.g.dart';

@riverpod
class LessonRecordFormNotifier
    extends _$LessonRecordFormNotifier {
  late final LessonRecordRepository repository;

  @override
  LessonRecordFormState build() {
    repository = LessonRecordRepository(
      academyApi: ref.read(academyApiProvider),
      lessonRecordApi: ref.read(lessonRecordApiProvider),
    );

    return LessonRecordFormState(
      isLoading: false,
    );
  }

  void setDescription(String description) {
    state = state.copyWith(
      lessonRecordForm: state.lessonRecordForm.copyWith(
        description: description,
      ),
    );
  }

  Future<bool> saveLessonRecord() async {
    final LessonRecordQueryState lessonRecordQueryState =
    ref.read(lessonRecordQueryProvider);

    final LessonRecordQuery lessonRecordQuery =
        lessonRecordQueryState.queryForm;

    if (!lessonRecordQuery.isValid) {
      return false;
    }

    state = state.copyWith(
      isSaving: true,
      errorMessage: null,
    );

    try {
      final LessonRecordForm lessonRecordForm =
          state.lessonRecordForm;

      final selectedAcademy =
      lessonRecordQuery.selectedAcademy!;

      final selectedAcademyClass =
      lessonRecordQuery.selectedAcademyClass!;

      final selectedSubject =
      lessonRecordQuery.selectedSubject!;

      final educationDate =
      lessonRecordQuery.educationDate!;

      final startTime =
      lessonRecordQuery.startTime!;

      final endTime =
      lessonRecordQuery.endTime!;

      final mainTeacher =
      lessonRecordQuery.mainTeacher!;

      final duration =
      endTime.difference(startTime);

      final LessonRecord record = LessonRecord(
        academyId: selectedAcademy.id,
        className: selectedAcademyClass.classNumber,
        subjectName: selectedSubject.name,
        educationDate: educationDate,
        educationDuration: duration,
        mainTeacherId: mainTeacher.sk,
        coTeacherIds: lessonRecordQuery.selectedCoTeachers
            .map((teacher) => teacher.sk)
            .toList(),
        memberIds: lessonRecordQuery.selectedStudents
            .map((member) => member.sk)
            .toList(),
        description: lessonRecordForm.description.trim(),
      );

      await repository.createLessonRecord(record);

      state = state.copyWith(
        isSaving: false,
        errorMessage: null,
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        isSaving: false,
        errorMessage: e.toString(),
      );

      return false;
    }
  }
}