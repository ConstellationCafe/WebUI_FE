import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/shared/domain/user/user_role.dart';
import 'package:constellation_cafe/shared/widgets/breadcrumb/app_breadcrumb.dart';

import '../../constants/erp_strings.dart';
import '../constants/penalty_strings.dart';
import '../constants/penalty_tokens.dart';
import '../domain/model/penalty_log.dart';
import '../notifier/admin_penalty_notifier.dart';
import '../widgets/admin_penalty_history_panel.dart';
import '../widgets/admin_penalty_ranking_panel.dart';
import '../widgets/admin_penalty_tab_bar.dart';
import '../widgets/penalty_award_dialog.dart';
import '../widgets/penalty_cancel_dialog.dart';
import '../widgets/penalty_context_menu_scope.dart';

/// 관리자 벌점 화면. 화면 조합과 다이얼로그 navigation만 담당한다.
///
/// 검색 입력 controller는 탭을 오가도 입력값이 유지되도록 page가 소유하고 각 탭에 전달한다.
class AdminPenaltyPage extends ConsumerStatefulWidget {
  const AdminPenaltyPage({super.key});

  @override
  ConsumerState<AdminPenaltyPage> createState() => _AdminPenaltyPageState();
}

class _AdminPenaltyPageState extends ConsumerState<AdminPenaltyPage> {
  final _channel = TextEditingController();
  final _discord = TextEditingController();
  final _ranking = TextEditingController();

  @override
  void dispose() {
    _channel.dispose();
    _discord.dispose();
    _ranking.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!ref.watch(currentUserStateProvider).roles.contains(UserRole.admin)) {
      return const Center(child: Text(PenaltyStrings.adminOnly));
    }
    final state = ref.watch(adminPenaltyProvider);
    return PenaltyContextMenuScope(
      child: Padding(
        padding: const EdgeInsets.all(PenaltyTokens.gap),
        child: DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppBreadcrumb(
                items: [ErpStrings.menuTitle, PenaltyStrings.title],
              ),
              const SizedBox(height: PenaltyTokens.cardGap),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: PenaltyTokens.gap,
                runSpacing: PenaltyTokens.gap,
                children: [
                  Text(
                    PenaltyStrings.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  ElevatedButton.icon(
                    onPressed: state.isSubmitting ? null : _showAward,
                    icon: const Icon(Icons.add),
                    label: const Text(PenaltyStrings.award),
                  ),
                ],
              ),
              const SizedBox(height: PenaltyTokens.headerToTabsGap),
              const AdminPenaltyTabBar(),
              Expanded(
                child: TabBarView(
                  children: [
                    AdminPenaltyHistoryPanel(
                      state: state,
                      channelController: _channel,
                      discordController: _discord,
                      onCancel: _showCancel,
                    ),
                    AdminPenaltyRankingPanel(
                      state: state,
                      searchController: _ranking,
                      onCancel: _showCancel,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showAward() async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => PenaltyAwardDialog(
        initialDiscordId: ref.read(adminPenaltyProvider).selectedId,
        onSubmit: ref.read(adminPenaltyProvider.notifier).award,
      ),
    );
    if (!mounted) return;
    if (result == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(PenaltyStrings.awarded)));
    } else {
      ref.read(adminPenaltyProvider.notifier).loadHistory();
    }
  }

  Future<void> _showCancel(PenaltyLog log) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => PenaltyCancelDialog(
        log: log,
        onSubmit: (reason) =>
            ref.read(adminPenaltyProvider.notifier).cancel(log.id, reason),
      ),
    );
    if (!mounted) return;
    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(PenaltyStrings.canceledResult)),
      );
    } else {
      ref.read(adminPenaltyProvider.notifier).loadHistory();
      final selected = ref.read(adminPenaltyProvider).selectedId;
      if (selected != null) {
        ref.read(adminPenaltyProvider.notifier).selectMember(selected);
      }
    }
  }
}
