import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/competition_strings.dart';
import '../constants/competition_tokens.dart';
import '../notifier/competition_winner_notifier.dart';
import '../widgets/competition_winner_form.dart';
import '../widgets/competition_winner_history.dart';

/// 우승 칭호 부여 화면. 넓은 화면은 부여 폼과 이력을 나란히, 좁은 화면은 위아래로 둔다.
class AdminCompetitionWinnerPage extends ConsumerWidget {
  /// 오늘 날짜의 기준. 테스트에서 주입한다.
  final DateTime Function() clock;

  const AdminCompetitionWinnerPage({super.key, this.clock = DateTime.now});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(competitionWinnerProvider);
    final notifier = ref.read(competitionWinnerProvider.notifier);

    final form = CompetitionWinnerForm(
      isSubmitting: state.isSubmitting,
      submit: notifier.grant,
      clock: clock,
    );
    final history = CompetitionWinnerHistory(
      items: state.history,
      isLoading: state.isLoadingHistory,
      hasError: state.hasHistoryError,
      page: state.historyPage,
      totalPages: state.historyTotalPages,
      onRetry: () => notifier.loadHistory(page: state.historyPage),
      onPageChanged: (page) => notifier.loadHistory(page: page),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact =
            constraints.maxWidth < CompetitionTokens.compactBreakpoint;
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: CompetitionTokens.fieldGap,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Semantics(
                header: true,
                child: Text(
                  CompetitionStrings.winnerTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const SizedBox(height: CompetitionTokens.fieldGap),
              if (isCompact) ...[
                form,
                const SizedBox(height: CompetitionTokens.sectionGap),
                history,
              ] else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: CompetitionTokens.formMaxWidth,
                      ),
                      child: form,
                    ),
                    const SizedBox(width: CompetitionTokens.sectionGap),
                    Expanded(child: history),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
