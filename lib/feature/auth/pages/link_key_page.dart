import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/link_key_strings.dart';
import '../constants/link_key_tokens.dart';
import '../widgets/link_key/link_key_issue_panel.dart';
import '../widgets/link_key/link_key_timer_panel.dart';

/// 카카오톡 봇 연동용 임시 키 발급 화면(개발 중, 아직 라우트에 연결하지 않음).
///
/// TODO: 서버 발급 API가 생기면 키 발급을 notifier로 옮긴다.
class LinkKeyPage extends StatefulWidget {
  /// 남은 시간 계산에 쓰는 현재 시각. 테스트에서 주입한다.
  final DateTime Function() clock;

  const LinkKeyPage({super.key, this.clock = DateTime.now});

  @override
  State<LinkKeyPage> createState() => _LinkKeyPageState();
}

class _LinkKeyPageState extends State<LinkKeyPage> {
  String? linkCode;
  DateTime? issuedAt;

  Timer? _timer;

  bool get hasCode => linkCode != null && issuedAt != null;

  Duration get remaining {
    if (!hasCode) return Duration.zero;
    final end = issuedAt!.add(LinkKeyTokens.keyTtl);
    final diff = end.difference(widget.clock());
    return diff.isNegative ? Duration.zero : diff;
  }

  bool get expired => hasCode && remaining == Duration.zero;

  double get progress {
    if (!hasCode) return 0;
    final total = LinkKeyTokens.keyTtl.inMilliseconds;
    final rem = remaining.inMilliseconds;
    return total == 0 ? 0 : (rem / total).clamp(0.0, 1.0);
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(LinkKeyTokens.refreshInterval, (_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _fmt(Duration d) {
    final mm = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final ss = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$mm:$ss';
  }

  Future<void> _issueKey() async {
    // TODO: 서버 호출
    // final res = await api.issueLinkKey(); // { code, issuedAt }
    setState(() {
      linkCode = _fakeSixDigits();
      issuedAt = widget.clock();
    });
  }

  String _fakeSixDigits() {
    final ms = widget.clock().millisecondsSinceEpoch;
    return (ms % 1000000).toString().padLeft(LinkKeyTokens.codeLength, '0');
  }

  Future<void> _copy() async {
    if (linkCode == null || expired) return;
    await Clipboard.setData(ClipboardData(text: linkCode!));
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text(LinkKeyStrings.copied)));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final remainingText = _fmt(remaining);
    final issuePanel = LinkKeyIssuePanel(
      activeCode: hasCode && !expired ? linkCode : null,
      remainingText: remainingText,
      onIssue: _issueKey,
      onCopy: _copy,
    );
    final timerPanel = LinkKeyTimerPanel(
      hasCode: hasCode,
      progress: progress,
      remainingText: remainingText,
    );

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, c) {
            final isWide = c.maxWidth >= LinkKeyTokens.wideBreakpoint;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: LinkKeyTokens.maxContentWidth,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(LinkKeyTokens.pagePadding),
                  child: isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: LinkKeyTokens.leftFlex,
                              child: issuePanel,
                            ),
                            const SizedBox(width: LinkKeyTokens.columnGap),
                            Expanded(
                              flex: LinkKeyTokens.rightFlex,
                              child: timerPanel,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            issuePanel,
                            const SizedBox(height: LinkKeyTokens.stackedGap),
                            timerPanel,
                          ],
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
