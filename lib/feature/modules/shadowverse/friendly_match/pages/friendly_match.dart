import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';
import 'package:constellation_cafe/shared/widgets/usage/usage.dart';

import '../constants/friendly_match_constants.dart';
import '../widgets/friendly_match_usage.dart';
import '../widgets/input_friendly_match.dart';
import '../widgets/view_friendly_match.dart';

class FriendlyMatch extends ConsumerStatefulWidget {
  const FriendlyMatch({super.key});

  @override
  ConsumerState<FriendlyMatch> createState() => _FriendlyMatchState();
}

class _FriendlyMatchState extends ConsumerState<FriendlyMatch> {
  final GlobalKey submitKey = GlobalKey();
  final GlobalKey inputDataKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Usage(
      usageKey: FriendlyMatchUsage.key,
      steps: FriendlyMatchUsage.steps(
        submitKey: submitKey,
        inputDataKey: inputDataKey,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = ScreenWidth.isDesktop(constraints.maxWidth);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(
              ConstSize.mediumSpacing,
            ),
            child: isDesktop
                ? _buildDesktop(constraints)
                : _buildMobile(constraints),
          );
        },
      ),
    );
  }

  Widget _buildDesktop(BoxConstraints constraints) {
    final availableWidth =
        constraints.maxWidth - (ConstSize.mediumSpacing * 2);

    final contentWidth = availableWidth.clamp(
      0.0,
      FriendlyMatchConstants.contentWidth,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ViewFriendlyMatch(
          submitKey: submitKey,
          width: contentWidth,
        ),
        const SizedBox(
          width: ConstSize.largeSpacing,
        ),
        InputFriendlyMatch(
          key: inputDataKey,
          width: contentWidth,
        ),
      ],
    );
  }

  Widget _buildMobile(BoxConstraints constraints) {
    final availableWidth =
        constraints.maxWidth - (ConstSize.mediumSpacing * 2);

    final contentWidth = availableWidth.clamp(
      0.0,
      FriendlyMatchConstants.contentWidth,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ViewFriendlyMatch(
          submitKey: submitKey,
          width: contentWidth,
        ),
        const SizedBox(
          height: ConstSize.largeSpacing,
        ),
        InputFriendlyMatch(
          key: inputDataKey,
          width: contentWidth,
        ),
      ],
    );
  }
}