import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/academy_permission.dart';

part 'academy_permission_state.freezed.dart';

@freezed
abstract class AcademyPermissionState with _$AcademyPermissionState {
  const factory AcademyPermissionState({
    @Default(false) bool isLoading,
    @Default(false) bool isInitialized,
    AcademyPermission? permission,
    String? errorMessage,
  }) = _AcademyPermissionState;

  factory AcademyPermissionState.initial() =>
      const AcademyPermissionState();
}