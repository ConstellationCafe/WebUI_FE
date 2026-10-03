import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/feature/modules/erp/constants/erp_strings.dart';
import 'package:constellation_cafe/shared/widgets/breadcrumb/app_breadcrumb.dart';
import 'package:constellation_cafe/shared/widgets/layout/page_width_limit.dart';

import '../constants/notification_strings.dart';
import '../constants/notification_tokens.dart';
import '../notifier/admin_notification_notifier.dart';
import '../widgets/admin_notification_form.dart';
import '../widgets/admin_notification_layout.dart';
import '../widgets/sent_notification_list.dart';

/// 관리자 알림 발행 화면. 넓은 화면은 작성 폼과 발행 이력을 나란히, 좁은 화면은 위아래로 둔다.
class AdminNotificationPage extends ConsumerWidget {
  const AdminNotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(adminNotificationProvider);
    final notifier = ref.read(adminNotificationProvider.notifier);

    final form = AdminNotificationForm(
      isSubmitting: state.isSubmitting,
      submit: notifier.publish,
    );
    final history = SentNotificationList(
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
            constraints.maxWidth < NotificationTokens.compactBreakpoint;
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: NotificationTokens.fieldGap,
          ),
          child: PageWidthLimit(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppBreadcrumb(
                  items: [ErpStrings.menuTitle, NotificationStrings.adminTitle],
                ),
                const SizedBox(height: NotificationTokens.panelGap),
                Semantics(
                  header: true,
                  child: Text(
                    NotificationStrings.adminTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: NotificationTokens.fieldGap),
                AdminNotificationLayout(
                  isCompact: isCompact,
                  form: form,
                  history: history,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
