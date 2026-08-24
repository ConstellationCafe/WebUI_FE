// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_status_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StudentStatusNotifier)
final studentStatusProvider = StudentStatusNotifierProvider._();

final class StudentStatusNotifierProvider
    extends $NotifierProvider<StudentStatusNotifier, StudentStatusState> {
  StudentStatusNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'studentStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$studentStatusNotifierHash();

  @$internal
  @override
  StudentStatusNotifier create() => StudentStatusNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StudentStatusState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StudentStatusState>(value),
    );
  }
}

String _$studentStatusNotifierHash() =>
    r'f25251fc737d9be61ddeb16fc410b5759e80857f';

abstract class _$StudentStatusNotifier extends $Notifier<StudentStatusState> {
  StudentStatusState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<StudentStatusState, StudentStatusState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StudentStatusState, StudentStatusState>,
              StudentStatusState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
