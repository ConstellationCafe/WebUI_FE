// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_record_query_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LessonRecordQueryNotifier)
final lessonRecordQueryProvider = LessonRecordQueryNotifierProvider._();

final class LessonRecordQueryNotifierProvider
    extends
        $NotifierProvider<LessonRecordQueryNotifier, LessonRecordQueryState> {
  LessonRecordQueryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lessonRecordQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lessonRecordQueryNotifierHash();

  @$internal
  @override
  LessonRecordQueryNotifier create() => LessonRecordQueryNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LessonRecordQueryState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LessonRecordQueryState>(value),
    );
  }
}

String _$lessonRecordQueryNotifierHash() =>
    r'0e075b8e33cca9e7f1941359c11794eee06749b2';

abstract class _$LessonRecordQueryNotifier
    extends $Notifier<LessonRecordQueryState> {
  LessonRecordQueryState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<LessonRecordQueryState, LessonRecordQueryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LessonRecordQueryState, LessonRecordQueryState>,
              LessonRecordQueryState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
