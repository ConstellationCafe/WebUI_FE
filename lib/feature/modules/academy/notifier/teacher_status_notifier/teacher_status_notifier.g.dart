// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_status_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TeacherStatusNotifier)
final teacherStatusProvider = TeacherStatusNotifierProvider._();

final class TeacherStatusNotifierProvider
    extends $NotifierProvider<TeacherStatusNotifier, TeacherStatusState> {
  TeacherStatusNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teacherStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teacherStatusNotifierHash();

  @$internal
  @override
  TeacherStatusNotifier create() => TeacherStatusNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TeacherStatusState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TeacherStatusState>(value),
    );
  }
}

String _$teacherStatusNotifierHash() =>
    r'746a553014d7c4d4c3932dd2e99e6bfd39f816a1';

abstract class _$TeacherStatusNotifier extends $Notifier<TeacherStatusState> {
  TeacherStatusState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<TeacherStatusState, TeacherStatusState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TeacherStatusState, TeacherStatusState>,
              TeacherStatusState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
