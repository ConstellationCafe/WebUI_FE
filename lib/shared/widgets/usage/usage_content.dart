import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/const_size.dart';

import 'constants/usage_constants.dart';
import 'constants/usage_strings.dart';

class UsageContent extends StatelessWidget {
  final String message;
  final VoidCallback onNext;
  final VoidCallback onPrev;
  final bool isLastStep;
  final bool isFirstStep;

  const UsageContent({
    super.key,
    required this.message,
    required this.onNext,
    required this.onPrev,
    required this.isLastStep,
    required this.isFirstStep,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ConstPadding.mediumPaddingAll,
      decoration: BoxDecoration(
        color: UsageConstants.contentPanelColor,
        borderRadius: BorderRadius.circular(UsageConstants.contentBorderRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            softWrap: true,
            overflow: TextOverflow.visible,
            style: const TextStyle(
              color: UsageConstants.contentForeground,
              fontSize: ConstSize.largeTextSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: ConstSize.mediumSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isFirstStep)
                GestureDetector(
                  onTap: onPrev,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: ConstPadding.mediumPadding,
                      vertical: ConstPadding.smallPadding,
                    ),
                    decoration: BoxDecoration(
                      color: UsageConstants.contentForeground.withValues(
                        alpha: UsageConstants.previousButtonBackgroundOpacity,
                      ),
                      borderRadius: BorderRadius.circular(
                        UsageConstants.navigationButtonRadius,
                      ),
                      border: Border.all(
                        color: UsageConstants.contentForeground.withValues(
                          alpha: UsageConstants.previousButtonBorderOpacity,
                        ),
                      ),
                    ),
                    child: const Text(
                      UsageStrings.previous,
                      style: TextStyle(color: UsageConstants.contentForeground),
                    ),
                  ),
                ),
              if (!isFirstStep) const SizedBox(width: ConstSize.smallSpacing),
              GestureDetector(
                onTap: onNext,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ConstPadding.mediumPadding,
                    vertical: ConstPadding.smallPadding,
                  ),
                  decoration: BoxDecoration(
                    color: UsageConstants.contentForeground.withValues(
                      alpha: UsageConstants.nextButtonBackgroundOpacity,
                    ),
                    borderRadius: BorderRadius.circular(
                      UsageConstants.navigationButtonRadius,
                    ),
                  ),
                  child: Text(
                    isLastStep ? UsageStrings.done : UsageStrings.next,
                    style: const TextStyle(
                      color: UsageConstants.contentForeground,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
