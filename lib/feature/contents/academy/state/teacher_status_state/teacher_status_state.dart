import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/teacher_status/teacher_status.dart';

part 'teacher_status_state.freezed.dart';

@freezed
abstract class TeacherStatusState with _$TeacherStatusState {
  const factory TeacherStatusState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    @Default(TeacherStatus()) TeacherStatus teacherStatus,
    String? errorMessage,
  }) = _TeacherStatusState;
}