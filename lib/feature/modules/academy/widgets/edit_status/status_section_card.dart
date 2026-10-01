import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

/// 상태 처리 화면의 제목·아이콘이 있는 구역 카드.
class StatusSectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const StatusSectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: ConstPadding.largePaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: ConstPadding.smallPadding),
                Text(title, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: ConstPadding.mediumPadding),
            child,
          ],
        ),
      ),
    );
  }
}
