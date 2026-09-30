import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/repository/competition_repository.dart';
import '../data/repository/competition_repository_provider.dart';
import '../domain/model/competition_winner.dart';
import '../state/competition_winner_state.dart';

part 'competition_winner_notifier.g.dart';

/// 우승 칭호 부여와 부여 이력.
@riverpod
class CompetitionWinnerNotifier extends _$CompetitionWinnerNotifier {
  late CompetitionRepository _repository;
  int _historyRequest = 0;

  @override
  CompetitionWinnerState build() {
    _repository = ref.read(competitionRepositoryProvider);
    scheduleMicrotask(() {
      if (ref.mounted && _historyRequest == 0) unawaited(loadHistory());
    });
    return const CompetitionWinnerState(isLoadingHistory: true);
  }

  Future<void> loadHistory({int page = 1}) async {
    if (!ref.mounted) return;
    final request = ++_historyRequest;
    state = state.copyWith(isLoadingHistory: true, hasHistoryError: false);
    try {
      final result = await _repository.getWinners(page: page);
      if (!ref.mounted || request != _historyRequest) return;
      state = state.copyWith(
        history: result.items,
        historyPage: result.page,
        historyTotalPages: result.totalPages,
        isLoadingHistory: false,
      );
    } catch (_) {
      if (!ref.mounted || request != _historyRequest) return;
      state = state.copyWith(isLoadingHistory: false, hasHistoryError: true);
    }
  }

  /// 부여에 성공하면 null, 실패하면 이유를 돌려준다. 진행 중에는 중복 실행하지 않는다.
  Future<CompetitionWinnerException?> grant(
    CompetitionWinnerDraft draft,
  ) async {
    if (!ref.mounted || state.isSubmitting) {
      return const CompetitionWinnerException(CompetitionWinnerFailure.unknown);
    }
    state = state.copyWith(isSubmitting: true);
    try {
      await _repository.grantWinner(draft);
      if (!ref.mounted) return null;
      state = state.copyWith(isSubmitting: false);
      unawaited(loadHistory());
      return null;
    } on CompetitionWinnerException catch (error) {
      if (ref.mounted) state = state.copyWith(isSubmitting: false);
      return error;
    } catch (_) {
      if (ref.mounted) state = state.copyWith(isSubmitting: false);
      return const CompetitionWinnerException(CompetitionWinnerFailure.unknown);
    }
  }
}
