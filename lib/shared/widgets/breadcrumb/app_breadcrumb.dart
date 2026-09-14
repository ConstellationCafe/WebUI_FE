import 'package:flutter/material.dart';

class AppBreadcrumb extends StatelessWidget {
  final List<String> items;

  const AppBreadcrumb({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: List.generate(
        items.length,
            (index) {
          final isLast = index == items.length - 1;

          return Row(
            children: [
              Text(
                items[index],
                style: textTheme.bodySmall?.copyWith(
                  fontWeight:
                  isLast ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              if (!isLast)
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Icon(
                    Icons.chevron_right,
                    size: 16,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}