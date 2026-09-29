import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/penalty_strings.dart';
import '../constants/penalty_tokens.dart';
import '../domain/model/penalty_log.dart';
import '../notifier/admin_penalty_notifier.dart';
import '../state/admin_penalty_state.dart';
import 'penalty_detail_panel.dart';
import 'penalty_load_error.dart';
import 'penalty_ranking_list.dart';

/// 30일 누적 순위 탭. 넓은 화면에서는 목록과 상세를 나란히, 좁은 화면에서는 세로로 쌓는다.
class AdminPenaltyRankingPanel extends ConsumerWidget {
  final AdminPenaltyState state;
  final TextEditingController searchController;
  final ValueChanged<PenaltyLog> onCancel;

  const AdminPenaltyRankingPanel({
    super.key,
    required this.state,
    required this.searchController,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(adminPenaltyProvider.notifier);
    final list = PenaltyRankingList(
      state: state,
      searchController: searchController,
    );
    final detail = state.isDetailLoading
        ? const Center(child: CircularProgressIndicator())
        : state.hasDetailError
        ? PenaltyLoadError(
            onRetry: () => notifier.selectMember(state.selectedId!),
          )
        : state.selected == null
        ? const Center(child: Text(PenaltyStrings.selectMember))
        : PenaltyDetailPanel(
            detail: state.selected!,
            showSummaryScore: false,
            isSubmitting: state.isSubmitting,
            onPageChanged: (page) =>
                notifier.selectMember(state.selectedId!, page: page),
            onCancel: onCancel,
          );

    return Padding(
      padding: const EdgeInsets.only(top: PenaltyTokens.gap),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < PenaltyTokens.breakpoint) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: PenaltyTokens.compactRankingListHeight,
                    child: list,
                  ),
                  const SizedBox(height: PenaltyTokens.gap),
                  SizedBox(
                    height: PenaltyTokens.compactRankingDetailHeight,
                    child: detail,
                  ),
                ],
              ),
            );
          }
          return Row(
            children: [
              SizedBox(width: PenaltyTokens.listWidth, child: list),
              const SizedBox(width: PenaltyTokens.gap),
              Expanded(child: detail),
            ],
          );
        },
      ),
    );
  }
}
