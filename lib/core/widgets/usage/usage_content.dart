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
    return Column(
      children: [
        Text(
          message,
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 이전 버튼 (첫 step이면 숨김)
            if (!isFirstStep)
              GestureDetector(
                onTap: onPrev,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: const Text(
                    '이전',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

            if (!isFirstStep) const SizedBox(width: 12),

            // 다음 / 확인 버튼
            GestureDetector(
              onTap: onNext,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
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
    );
  }
}