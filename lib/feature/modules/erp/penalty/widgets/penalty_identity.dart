import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/penalty_strings.dart';

enum _CopyValue { nickname, discordId }

class PenaltyIdentity extends StatelessWidget {
  final String username;
  final String discordId;
  final Widget child;

  const PenaltyIdentity({
    super.key,
    required this.username,
    required this.discordId,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onSecondaryTapDown: (details) =>
        _showCopyMenu(context, details.globalPosition),
    child: child,
  );

  Future<void> _showCopyMenu(
    BuildContext context,
    Offset globalPosition,
  ) async {
    final overlay =
        Overlay.of(context).context.findRenderObject()! as RenderBox;
    final position = overlay.globalToLocal(globalPosition);
    final choice = await showMenu<_CopyValue>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        overlay.size.width - position.dx,
        overlay.size.height - position.dy,
      ),
      items: const [
        PopupMenuItem(
          value: _CopyValue.nickname,
          child: Text(PenaltyStrings.copyNickname),
        ),
        PopupMenuItem(
          value: _CopyValue.discordId,
          child: Text(PenaltyStrings.copyDiscordId),
        ),
      ],
    );
    if (choice == null) return;
    final isNickname = choice == _CopyValue.nickname;
    await Clipboard.setData(
      ClipboardData(text: isNickname ? username : discordId),
    );
    if (context.mounted) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SnackBar(
          content: Text(
            isNickname
                ? PenaltyStrings.copiedNickname
                : PenaltyStrings.copiedDiscordId,
          ),
        ),
      );
    }
  }
}
