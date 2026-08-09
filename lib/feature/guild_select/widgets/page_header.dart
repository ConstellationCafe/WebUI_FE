import 'package:flutter/material.dart';

class SelectPageHeader extends StatelessWidget {
  const SelectPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            Icons.bar_chart_rounded,
            size: 34,
            color: theme.colorScheme.secondary,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          '사용할 채팅방을 선택해주세요',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium,
        ),

        const SizedBox(height: 8),

        Text(
          '관리할 Discord 채팅방을 선택하면 ERP 서비스를 이용할 수 있습니다.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}