// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_editor_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// DB 편집기의 조회·검색·정렬·편집·저장 action.
///
/// 편집기 화면([repository])마다 하나씩 만들어지고, 화면이 사라지면 함께 정리된다.

@ProviderFor(DbEditorNotifier)
final dbEditorProvider = DbEditorNotifierFamily._();

/// DB 편집기의 조회·검색·정렬·편집·저장 action.
///
/// 편집기 화면([repository])마다 하나씩 만들어지고, 화면이 사라지면 함께 정리된다.
final class DbEditorNotifierProvider
    extends $NotifierProvider<DbEditorNotifier, DbEditorState> {
  /// DB 편집기의 조회·검색·정렬·편집·저장 action.
  ///
  /// 편집기 화면([repository])마다 하나씩 만들어지고, 화면이 사라지면 함께 정리된다.
  DbEditorNotifierProvider._({
    required DbEditorNotifierFamily super.from,
    required RepositoryInterface<Entity> super.argument,
  }) : super(
         retry: null,
         name: r'dbEditorProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dbEditorNotifierHash();

  @override
  String toString() {
    return r'dbEditorProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DbEditorNotifier create() => DbEditorNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DbEditorState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DbEditorState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DbEditorNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dbEditorNotifierHash() => r'2a1ca711ef6642b0bf3610118dd6fc6744a73dc9';

/// DB 편집기의 조회·검색·정렬·편집·저장 action.
///
/// 편집기 화면([repository])마다 하나씩 만들어지고, 화면이 사라지면 함께 정리된다.

final class DbEditorNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          DbEditorNotifier,
          DbEditorState,
          DbEditorState,
          DbEditorState,
          RepositoryInterface<Entity>
        > {
  DbEditorNotifierFamily._()
    : super(
        retry: null,
        name: r'dbEditorProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// DB 편집기의 조회·검색·정렬·편집·저장 action.
  ///
  /// 편집기 화면([repository])마다 하나씩 만들어지고, 화면이 사라지면 함께 정리된다.

  DbEditorNotifierProvider call(RepositoryInterface<Entity> repository) =>
      DbEditorNotifierProvider._(argument: repository, from: this);

  @override
  String toString() => r'dbEditorProvider';
}

/// DB 편집기의 조회·검색·정렬·편집·저장 action.
///
/// 편집기 화면([repository])마다 하나씩 만들어지고, 화면이 사라지면 함께 정리된다.

abstract class _$DbEditorNotifier extends $Notifier<DbEditorState> {
  late final _$args = ref.$arg as RepositoryInterface<Entity>;
  RepositoryInterface<Entity> get repository => _$args;

  DbEditorState build(RepositoryInterface<Entity> repository);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DbEditorState, DbEditorState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DbEditorState, DbEditorState>,
              DbEditorState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
