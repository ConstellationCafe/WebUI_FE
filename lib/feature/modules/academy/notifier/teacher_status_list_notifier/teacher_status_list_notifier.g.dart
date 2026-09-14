// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_status_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TeacherStatusListNotifier)
final teacherStatusListProvider = TeacherStatusListNotifierProvider._();

final class TeacherStatusListNotifierProvider
    extends
        $NotifierProvider<TeacherStatusListNotifier, TeacherStatusListState> {
  TeacherStatusListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teacherStatusListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teacherStatusListNotifierHash();

  @$internal
  @override
  TeacherStatusListNotifier create() => TeacherStatusListNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TeacherStatusListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TeacherStatusListState>(value),
    );
  }
}

String _$teacherStatusListNotifierHash() =>
    r'4b154b913b229116e60e42ab009113885cc27205';

abstract class _$TeacherStatusListNotifier
    extends $Notifier<TeacherStatusListState> {
  TeacherStatusListState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<TeacherStatusListState, TeacherStatusListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TeacherStatusListState, TeacherStatusListState>,
              TeacherStatusListState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
