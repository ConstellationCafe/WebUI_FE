// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_status_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StudentStatusListNotifier)
final studentStatusListProvider = StudentStatusListNotifierProvider._();

final class StudentStatusListNotifierProvider
    extends
        $NotifierProvider<StudentStatusListNotifier, StudentStatusListState> {
  StudentStatusListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'studentStatusListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$studentStatusListNotifierHash();

  @$internal
  @override
  StudentStatusListNotifier create() => StudentStatusListNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StudentStatusListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StudentStatusListState>(value),
    );
  }
}

String _$studentStatusListNotifierHash() =>
    r'f7bdaab36a910f6e212773d47abfa129da702d2b';

abstract class _$StudentStatusListNotifier
    extends $Notifier<StudentStatusListState> {
  StudentStatusListState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<StudentStatusListState, StudentStatusListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StudentStatusListState, StudentStatusListState>,
              StudentStatusListState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
