import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/student_status/student_status.dart';

part 'student_status_state.freezed.dart';

@freezed
abstract class StudentStatusState with _$StudentStatusState {
  const factory StudentStatusState({
    @Default(false)
    bool isLoading,
    @Default(false)
    bool isProcessing,
    StudentStatus? studentStatus,
    String? errorMessage,
  }) = _StudentStatusState;
}