// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competition_winner_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 우승 칭호 부여와 부여 이력.

@ProviderFor(CompetitionWinnerNotifier)
final competitionWinnerProvider = CompetitionWinnerNotifierProvider._();

/// 우승 칭호 부여와 부여 이력.
final class CompetitionWinnerNotifierProvider
    extends
        $NotifierProvider<CompetitionWinnerNotifier, CompetitionWinnerState> {
  /// 우승 칭호 부여와 부여 이력.
  CompetitionWinnerNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'competitionWinnerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$competitionWinnerNotifierHash();

  @$internal
  @override
  CompetitionWinnerNotifier create() => CompetitionWinnerNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CompetitionWinnerState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CompetitionWinnerState>(value),
    );
  }
}

String _$competitionWinnerNotifierHash() =>
    r'14068eb6bf3683b65b7f7c3049a365451ee46f16';

/// 우승 칭호 부여와 부여 이력.

abstract class _$CompetitionWinnerNotifier
    extends $Notifier<CompetitionWinnerState> {
  CompetitionWinnerState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<CompetitionWinnerState, CompetitionWinnerState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CompetitionWinnerState, CompetitionWinnerState>,
              CompetitionWinnerState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
