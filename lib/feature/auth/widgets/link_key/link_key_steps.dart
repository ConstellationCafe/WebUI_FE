import 'package:flutter/material.dart';

import '../../constants/link_key_strings.dart';
import '../../constants/link_key_tokens.dart';
import 'link_key_step_card.dart';

/// 카카오 로그인 → 키 발급 → 카카오톡 입력 3단계 안내.
class LinkKeySteps extends StatelessWidget {
  const LinkKeySteps({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: LinkKeyStepCard(
            number: '1',
            title: LinkKeyStrings.step1Title,
            description: LinkKeyStrings.step1Description,
          ),
        ),
        SizedBox(width: LinkKeyTokens.gap),
        Expanded(
          child: LinkKeyStepCard(
            number: '2',
            title: LinkKeyStrings.step2Title,
            description: LinkKeyStrings.step2Description,
          ),
        ),
        SizedBox(width: LinkKeyTokens.gap),
        Expanded(
          child: LinkKeyStepCard(
            number: '3',
            title: LinkKeyStrings.step3Title,
            description: LinkKeyStrings.step3Description,
          ),
        ),
      ],
    );
  }
}
