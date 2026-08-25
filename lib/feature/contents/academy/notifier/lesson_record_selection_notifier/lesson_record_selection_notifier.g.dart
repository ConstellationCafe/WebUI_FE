// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_record_selection_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LessonRecordSelectionNotifier)
final lessonRecordSelectionProvider = LessonRecordSelectionNotifierProvider._();

final class LessonRecordSelectionNotifierProvider
    extends
        $NotifierProvider<
          LessonRecordSelectionNotifier,
          LessonRecordSelectionState
        > {
  LessonRecordSelectionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lessonRecordSelectionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lessonRecordSelectionNotifierHash();

  @$internal
  @override
  LessonRecordSelectionNotifier create() => LessonRecordSelectionNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LessonRecordSelectionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LessonRecordSelectionState>(value),
    );
  }
}

String _$lessonRecordSelectionNotifierHash() =>
    r'6b7ce4cecb3c71e55dbba99f40e18220bd28d9e7';

abstract class _$LessonRecordSelectionNotifier
    extends $Notifier<LessonRecordSelectionState> {
  LessonRecordSelectionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<LessonRecordSelectionState, LessonRecordSelectionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                LessonRecordSelectionState,
                LessonRecordSelectionState
              >,
              LessonRecordSelectionState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
