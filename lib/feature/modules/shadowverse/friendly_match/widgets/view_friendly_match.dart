import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/const_size.dart';

import '../../constants/shadowverse_strings.dart';
import '../constants/friendly_match_constants.dart';
import '../notifier/friendly_match_notifier.dart';
import 'submit_button.dart';

/// 입력한 친선전 모집 글 미리보기와 전송 버튼.
class ViewFriendlyMatch extends ConsumerWidget {
  final double width;
  final GlobalKey? submitKey;

  const ViewFriendlyMatch({super.key, required this.width, this.submitKey});

  static const _bold = TextStyle(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(friendlyMatchProvider);

    return SizedBox(
      width: width,
      child: Container(
        padding: ConstPadding.largePaddingAll,
        decoration: FriendlyMatchConstants.cardDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(ShadowverseStrings.cafeName, style: _bold),
                    Text(ShadowverseStrings.senderMatch(state.sender)),
                  ],
                ),
                const Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    FriendlyMatchConstants.cafeIconRadius,
                  ),
                  child: Image.asset(
                    FriendlyMatchConstants.cafeIcon,
                    width: FriendlyMatchConstants.cafeIconSize,
                    height: FriendlyMatchConstants.cafeIconSize,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const Text(ShadowverseStrings.versionTitle, style: _bold),
            Text(state.version),
            const Text(ShadowverseStrings.modeTitle, style: _bold),
            Text(state.mode),
            const Text(ShadowverseStrings.platformTitle, style: _bold),
            Text(state.platform),
            const Text(ShadowverseStrings.roomTitle, style: _bold),
            Text(state.roomNumber),
            if (state.message.isNotEmpty) ...[
              const Text(ShadowverseStrings.messageTitle, style: _bold),
              Text(state.message),
            ],
            Row(
              children: [
                const Expanded(
                  child: Text(
                    ShadowverseStrings.howToRecruit,
                    softWrap: true,
                    maxLines: FriendlyMatchConstants.howToRecruitMaxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: ConstSize.largeSpacing),
                SubmitButton(key: submitKey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
