import 'package:freezed_annotation/freezed_annotation.dart';

import '../lesson_record_view.dart';

part 'lesson_record_list.freezed.dart';

@freezed
abstract class LessonRecordList with _$LessonRecordList {
  const factory LessonRecordList({
    @Default([]) List<LessonRecordView> records,
  }) = _LessonRecordList;
}