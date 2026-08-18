// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_record_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LessonRecordListNotifier)
final lessonRecordListProvider = LessonRecordListNotifierProvider._();

final class LessonRecordListNotifierProvider
    extends $NotifierProvider<LessonRecordListNotifier, LessonRecordListState> {
  LessonRecordListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lessonRecordListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lessonRecordListNotifierHash();

  @$internal
  @override
  LessonRecordListNotifier create() => LessonRecordListNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LessonRecordListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LessonRecordListState>(value),
    );
  }
}

String _$lessonRecordListNotifierHash() =>
    r'55224ef1ab9c7204e9f714c1ee0edb1e6298bd7f';

abstract class _$LessonRecordListNotifier
    extends $Notifier<LessonRecordListState> {
  LessonRecordListState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LessonRecordListState, LessonRecordListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LessonRecordListState, LessonRecordListState>,
              LessonRecordListState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
