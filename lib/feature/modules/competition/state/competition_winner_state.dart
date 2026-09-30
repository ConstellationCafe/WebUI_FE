import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/model/competition_winner.dart';

part 'competition_winner_state.freezed.dart';

/// 우승 칭호 부여 화면 상태. 입력값은 폼 위젯이 소유하고,
/// 여기에는 부여 진행과 부여 이력 조회 상태만 둔다.
@freezed
abstract class CompetitionWinnerState with _$CompetitionWinnerState {
  const factory CompetitionWinnerState({
    @Default([]) List<CompetitionWinner> history,
    @Default(1) int historyPage,
    @Default(0) int historyTotalPages,
    @Default(false) bool isLoadingHistory,
    @Default(false) bool hasHistoryError,
    @Default(false) bool isSubmitting,
  }) = _CompetitionWinnerState;
}
