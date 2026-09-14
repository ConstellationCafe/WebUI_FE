import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:flutter/material.dart';

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
        color: Colors.black.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
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
              color: Colors.white,
              fontSize: ConstSize.largeTextSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: ConstSize.mediumSpacing,
          ),
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
                      color: Colors.white.withValues(
                        alpha: 0.15,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(
                          alpha: 0.3,
                        ),
                      ),
                    ),
                    child: const Text(
                      '이전',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              if (!isFirstStep)
                const SizedBox(
                  width: ConstSize.smallSpacing,
                ),
              GestureDetector(
                onTap: onNext,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ConstPadding.mediumPadding,
                    vertical: ConstPadding.smallPadding,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(
                      alpha: 0.25,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isLastStep ? '확인' : '다음',
                    style: const TextStyle(
                      color: Colors.white,
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