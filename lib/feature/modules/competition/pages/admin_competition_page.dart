import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/shared/widgets/breadcrumb/app_breadcrumb.dart';
import 'package:constellation_cafe/shared/widgets/layout/page_width_limit.dart';

import '../constants/competition_strings.dart';
import '../constants/competition_tokens.dart';
import '../notifier/admin_competition_notifier.dart';
import '../widgets/competition_form.dart';
import '../widgets/competition_preview_panel.dart';

/// 대회 개최 화면. 넓은 화면은 입력 폼과 미리보기를 나란히, 좁은 화면은 위아래로 둔다.
class AdminCompetitionPage extends ConsumerWidget {
  /// 접수 마감 검증과 날짜 선택 기준 시각. 테스트에서 주입한다.
  final DateTime Function() clock;

  const AdminCompetitionPage({super.key, this.clock = DateTime.now});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(adminCompetitionProvider);
    final notifier = ref.read(adminCompetitionProvider.notifier);

    final form = CompetitionForm(
      boards: state.boards,
      selectedBoardKey: state.selectedBoardKey,
      isLoadingBoards: state.isLoadingBoards,
      hasBoardsError: state.hasBoardsError,
      isSubmitting: state.isSubmitting,
      onBoardChanged: notifier.selectBoard,
      onRetryBoards: notifier.loadBoards,
      onDraftChanged: notifier.preview,
      submit: (requestId, draft) =>
          notifier.post(requestId: requestId, draft: draft),
      clock: clock,
    );
    final preview = CompetitionPreviewPanel(
      preview: state.preview,
      failure: state.previewFailure,
      isPreviewing: state.isPreviewing,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact =
            constraints.maxWidth < CompetitionTokens.compactBreakpoint;
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: CompetitionTokens.fieldGap,
          ),
          child: PageWidthLimit(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppBreadcrumb(
                  items: [
                    CompetitionStrings.menuTitle,
                    CompetitionStrings.title,
                  ],
                ),
                const SizedBox(height: CompetitionTokens.rowGap),
                Semantics(
                  header: true,
                  child: Text(
                    CompetitionStrings.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: CompetitionTokens.fieldGap),
                if (isCompact) ...[
                  form,
                  const SizedBox(height: CompetitionTokens.sectionGap),
                  preview,
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
                      Expanded(child: preview),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
