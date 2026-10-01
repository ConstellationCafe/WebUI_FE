import 'package:flutter/material.dart';

import '../constants/penalty_strings.dart';

class PenaltyPager extends StatelessWidget {
  final int page;
  final int totalPages;
  final bool disabled;
  final ValueChanged<int> onChanged;

  const PenaltyPager({
    super.key,
    required this.page,
    required this.totalPages,
    required this.disabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
        tooltip: PenaltyStrings.previousPage,
        onPressed: !disabled && page > 1 ? () => onChanged(page - 1) : null,
        icon: const Icon(Icons.chevron_left),
      ),
      Text(
        PenaltyStrings.pageIndicator(page, totalPages == 0 ? 1 : totalPages),
      ),
      IconButton(
        tooltip: PenaltyStrings.nextPage,
        onPressed: !disabled && page < totalPages
            ? () => onChanged(page + 1)
            : null,
        icon: const Icon(Icons.chevron_right),
      ),
    ],
  );
}
