import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/penalty_strings.dart';
import '../constants/penalty_tokens.dart';
import '../domain/calculate_penalty_cumulative.dart';
import '../domain/model/penalty_log.dart';
import '../domain/type/penalty_history_sort.dart';
import '../notifier/admin_penalty_notifier.dart';
import '../state/admin_penalty_state.dart';
import 'penalty_id_input_formatters.dart';
import 'penalty_load_error.dart';
import 'penalty_log_tile.dart';
import 'penalty_pager.dart';

/// 벌점 이력 탭. 채널·대상 검색, 정렬, 이력 목록과 페이지 이동을 보여준다.
///
/// 검색 조건도 목록과 함께 스크롤되어, 좁은 화면에서 조건이 화면에 고정된 채 목록이
/// 작게 보이지 않게 한다. [scrollsWithPage]이면 화면의 `NestedScrollView`와 이어지도록
/// primary scroll view로 만든다.
class AdminPenaltyHistoryPanel extends ConsumerWidget {
  final AdminPenaltyState state;
  final TextEditingController channelController;
  final TextEditingController discordController;
  final ValueChanged<PenaltyLog> onCancel;
  final bool scrollsWithPage;

  const AdminPenaltyHistoryPanel({
    super.key,
    required this.state,
    required this.channelController,
    required this.discordController,
    required this.onCancel,
    this.scrollsWithPage = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(adminPenaltyProvider.notifier);
    final history = state.history;
    final cumulativeScores = history == null
        ? const <int>[]
        : cumulativeScoresForLogs(
            logs: history.items,
            newestFirst: state.sort == PenaltyHistorySort.newest,
          );
    void search() => notifier.loadHistory(
      channelId: channelController.text,
      discordId: discordController.text,
    );

    final filters = Padding(
      padding: const EdgeInsets.symmetric(vertical: PenaltyTokens.gap),
      child: Wrap(
        spacing: PenaltyTokens.gap,
        runSpacing: PenaltyTokens.gap,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: PenaltyTokens.historyFilterFieldWidth,
            child: TextField(
              controller: channelController,
              keyboardType: TextInputType.number,
              inputFormatters: penaltyIdInputFormatters(),
              decoration: const InputDecoration(
                labelText: PenaltyStrings.channelId,
              ),
              onSubmitted: (_) => search(),
            ),
          ),
          SizedBox(
            width: PenaltyTokens.historyFilterFieldWidth,
            child: TextField(
              controller: discordController,
              keyboardType: TextInputType.number,
              inputFormatters: penaltyIdInputFormatters(),
              decoration: const InputDecoration(
                labelText: PenaltyStrings.targetId,
              ),
              onSubmitted: (_) => search(),
            ),
          ),
          SizedBox(
            width: PenaltyTokens.historySortFieldWidth,
            child: DropdownButtonFormField<String>(
              // 정렬 값은 notifier state가 소유한다. initialValue로 바꾸면 state 변경이
              // 반영되지 않으므로 controlled value를 유지한다.
              // ignore: deprecated_member_use
              value: state.sort,
              decoration: const InputDecoration(labelText: PenaltyStrings.sort),
              items: const [
                DropdownMenuItem(
                  value: PenaltyHistorySort.newest,
                  child: Text(PenaltyStrings.sortNewest),
                ),
                DropdownMenuItem(
                  value: PenaltyHistorySort.oldest,
                  child: Text(PenaltyStrings.sortOldest),
                ),
              ],
              onChanged: (value) => value == null
                  ? null
                  : notifier.loadHistory(page: 1, sort: value),
            ),
          ),
          ElevatedButton.icon(
            onPressed: search,
            icon: const Icon(Icons.search),
            label: const Text(PenaltyStrings.search),
          ),
        ],
      ),
    );

    final Widget body;
    if (state.isHistoryLoading) {
      body = const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (state.hasHistoryError) {
      body = SliverFillRemaining(
        hasScrollBody: false,
        child: PenaltyLoadError(
          onRetry: () => notifier.loadHistory(page: history?.page ?? 1),
        ),
      );
    } else if (history == null || history.items.isEmpty) {
      body = const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: Text(PenaltyStrings.noHistory)),
      );
    } else {
      body = SliverList.separated(
        itemCount: history.items.length,
        separatorBuilder: (_, _) =>
            const SizedBox(height: PenaltyTokens.cardGap),
        itemBuilder: (context, index) {
          final log = history.items[index];
          return PenaltyLogTile(
            log: log,
            cumulativeScore: cumulativeScores[index],
            onCancel: log.isCanceled || state.isSubmitting
                ? null
                : () => onCancel(log),
          );
        },
      );
    }

    return CustomScrollView(
      primary: scrollsWithPage ? true : null,
      slivers: [
        SliverToBoxAdapter(child: filters),
        body,
        SliverToBoxAdapter(
          child: PenaltyPager(
            page: history?.page ?? 1,
            totalPages: history?.totalPages ?? 0,
            disabled: state.isHistoryLoading,
            onChanged: (page) => notifier.loadHistory(page: page),
          ),
        ),
      ],
    );
  }
}
