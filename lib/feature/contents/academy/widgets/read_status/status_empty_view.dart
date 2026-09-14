import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';

class StatusEmptyView extends StatelessWidget {
  final String message;

  const StatusEmptyView({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: ConstPadding.largePaddingAll,
        child: Column(
          children: [
            Icon(
              Icons.person_search_outlined,
              size: AcademyConstants.emptyIconSize,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(
              height: ConstPadding.mediumPadding,
            ),
            Text(
              message,
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}