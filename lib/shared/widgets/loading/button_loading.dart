import 'package:flutter/material.dart';

import '../../constants/loading_tokens.dart';

/// 버튼 label 자리에 두는 작은 진행 표시.
class ButtonLoading extends StatelessWidget {
  const ButtonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      strokeWidth: LoadingTokens.buttonStrokeWidth,
      color: LoadingTokens.buttonIndicatorColor,
    );
  }
}
