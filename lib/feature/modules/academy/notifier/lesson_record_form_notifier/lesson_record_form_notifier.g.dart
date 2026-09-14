// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_record_form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LessonRecordFormNotifier)
final lessonRecordFormProvider = LessonRecordFormNotifierProvider._();

final class LessonRecordFormNotifierProvider
    extends $NotifierProvider<LessonRecordFormNotifier, LessonRecordFormState> {
  LessonRecordFormNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lessonRecordFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lessonRecordFormNotifierHash();

  @$internal
  @override
  LessonRecordFormNotifier create() => LessonRecordFormNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LessonRecordFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LessonRecordFormState>(value),
    );
  }
}

String _$lessonRecordFormNotifierHash() =>
    r'e1077b4e511a10d9656e9a8492735a5aa0958d1a';

abstract class _$LessonRecordFormNotifier
    extends $Notifier<LessonRecordFormState> {
  LessonRecordFormState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LessonRecordFormState, LessonRecordFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LessonRecordFormState, LessonRecordFormState>,
              LessonRecordFormState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
