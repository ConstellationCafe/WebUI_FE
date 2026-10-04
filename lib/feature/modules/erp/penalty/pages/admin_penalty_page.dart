import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/shared/domain/user/user_role.dart';
import 'package:constellation_cafe/shared/widgets/breadcrumb/app_breadcrumb.dart';
import 'package:constellation_cafe/shared/widgets/layout/page_width_limit.dart';

import '../../constants/erp_strings.dart';
import '../constants/penalty_strings.dart';
import '../constants/penalty_tokens.dart';
import '../domain/model/penalty_log.dart';
import '../notifier/admin_penalty_notifier.dart';
import '../notifier/penalty_permission_notifier.dart';
import '../state/admin_penalty_state.dart';
import '../widgets/admin_penalty_history_panel.dart';
import '../widgets/admin_penalty_ranking_panel.dart';
import '../widgets/admin_penalty_tab_bar.dart';
import '../widgets/penalty_award_dialog.dart';
import '../widgets/penalty_cancel_dialog.dart';
import '../widgets/penalty_context_menu_scope.dart';

/// 벌점 관리 화면. 화면 조합과 다이얼로그 navigation만 담당한다.
/// 운영 매니저·운영 본부원 역할 또는 서버장만 볼 수 있다(최종 판단은 서버).
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
    // 넓은 화면에서 쓸데없이 넓어지지 않게 공용 최대 너비 안에서 가운데에 둔다.
    return PageWidthLimit(child: _content(context));
  }

  Widget _content(BuildContext context) {
    final isAdmin = ref.watch(
      currentUserStateProvider.select(
        (state) => state.roles.contains(UserRole.admin),
      ),
    );
    final permission = ref.watch(penaltyPermissionProvider);
    if (!isAdmin && !permission.isManager) {
      // 새로고침 직후처럼 권한을 아직 확인하지 못했으면 안내 대신 기다린다.
      if (permission.isLoading || !permission.isInitialized) {
        return const Center(child: CircularProgressIndicator());
      }
      return const Center(child: Text(PenaltyStrings.managerOnly));
    }
    final state = ref.watch(adminPenaltyProvider);
    return PenaltyContextMenuScope(
      child: Padding(
        padding: const EdgeInsets.all(PenaltyTokens.gap),
        child: DefaultTabController(
          length: 2,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < PenaltyTokens.breakpoint;
              final tabs = TabBarView(
                children: [
                  AdminPenaltyHistoryPanel(
                    state: state,
                    channelController: _channel,
                    discordController: _discord,
                    onCancel: _showCancel,
                    scrollsWithPage: compact,
                  ),
                  AdminPenaltyRankingPanel(
                    state: state,
                    searchController: _ranking,
                    onCancel: _showCancel,
                  ),
                ],
              );
              if (compact) {
                // 좁은 화면에서는 제목·탭도 목록과 함께 스크롤되어 이력이 화면을 넓게 쓴다.
                return NestedScrollView(
                  headerSliverBuilder: (context, _) => [
                    SliverToBoxAdapter(child: _header(context, state)),
                  ],
                  body: tabs,
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _header(context, state),
                  Expanded(child: tabs),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context, AdminPenaltyState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
      ],
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
