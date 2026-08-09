import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LinkKeyPage extends StatefulWidget {
  const LinkKeyPage({super.key});

  @override
  State<LinkKeyPage> createState() => _LinkKeyPageState();
}

class _LinkKeyPageState extends State<LinkKeyPage> {
  String? linkCode;
  DateTime? issuedAt;
  final Duration ttl = const Duration(minutes: 1);

  Timer? _timer;

  bool get hasCode => linkCode != null && issuedAt != null;

  Duration get remaining {
    if (!hasCode) return Duration.zero;
    final end = issuedAt!.add(ttl);
    final diff = end.difference(DateTime.now());
    return diff.isNegative ? Duration.zero : diff;
  }

  bool get expired => hasCode && remaining == Duration.zero;

  double get progress {
    if (!hasCode) return 0;
    final total = ttl.inMilliseconds;
    final rem = remaining.inMilliseconds;
    return total == 0 ? 0 : (rem / total).clamp(0.0, 1.0);
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
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
      issuedAt = DateTime.now();
    });
  }

  String _fakeSixDigits() {
    final ms = DateTime.now().millisecondsSinceEpoch;
    return (ms % 1000000).toString().padLeft(6, '0');
  }

  Future<void> _copy() async {
    if (linkCode == null || expired) return;
    await Clipboard.setData(ClipboardData(text: linkCode!));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('연동 키를 복사했어요.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface, // #F5F6F7
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, c) {
            final isWide = c.maxWidth >= 1100;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1280),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: isWide
                      ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 8, child: _Left(cs)),
                      const SizedBox(width: 24),
                      Expanded(flex: 4, child: _Right(cs)),
                    ],
                  )
                      : Column(
                    children: [
                      _Left(cs),
                      const SizedBox(height: 16),
                      _Right(cs),
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

  Widget _TopBar(ColorScheme cs) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: cs.primary, // white
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outlineVariant.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: cs.secondary, // #000D27
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '임시 연동 키 발급',
            style: TextStyle(
              color: cs.secondary,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          Text(
            '연동 상태: 로그인 필요',
            style: TextStyle(color: cs.onSurface.withOpacity(0.7)),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {
              // TODO: 카카오 OAuth 로그인
            },
            child: const Text('카카오로 로그인'),
          ),
        ],
      ),
    );
  }

  Widget _Left(ColorScheme cs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _TopBar(cs),
        const SizedBox(height: 16),
        _Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1분 유효한 임시 연동 키',
                  style: TextStyle(
                    color: cs.secondary,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '웹에서 키를 발급하고 카카오톡에서 입력하면 봇이 연결됩니다.',
                  style: TextStyle(color: cs.onSurface),
                ),
                const SizedBox(height: 18),
                _Steps(cs),
                const SizedBox(height: 22),
                Text(
                  '연동 키',
                  style: TextStyle(
                    color: cs.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _KeyBox(cs),
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: (hasCode && !expired) ? _copy : null,
                        child: const Text('복사'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _issueKey,
                        child: Text(hasCode && !expired ? '새 키 발급(덮어쓰기)' : '키 발급'),
                      ),
                    ),
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: null, // TODO: 쿨다운 정책이 있으면 여기서 활성화 제어
                        child: Text(
                          hasCode && !expired ? '재발급(${_fmt(remaining)} 후)' : '재발급',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '보안 안내: 키는 1분 후 만료되며, 1회만 연결에 사용됩니다.',
                  style: TextStyle(color: cs.onSurface.withOpacity(0.65)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _Right(ColorScheme cs) {
    return _Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '만료까지',
              style: TextStyle(
                color: cs.secondary,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: SizedBox(
                width: 160,
                height: 160,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: hasCode ? progress : 0,
                      strokeWidth: 12,
                      backgroundColor: cs.outlineVariant.withOpacity(0.15),
                      valueColor: AlwaysStoppedAnimation(cs.secondary),
                    ),
                    Text(
                      hasCode ? _fmt(remaining) : '--:--',
                      style: TextStyle(
                        color: cs.secondary,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'QR로 입력하기(선택)',
              style: TextStyle(color: cs.secondary, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: cs.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: cs.outlineVariant.withOpacity(0.15)),
                ),
                child: Center(
                  child: Text(
                    'QR 영역',
                    style: TextStyle(color: cs.onSurface.withOpacity(0.6)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              '카카오톡에서 이렇게 입력',
              style: TextStyle(color: cs.secondary, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cs.surface.withOpacity(0.6),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: cs.outlineVariant.withOpacity(0.15)),
              ),
              child: const Text(
                '봇 채팅방에서\n/link 123456\n처럼 입력하면 연결됩니다.\n연결 완료 시 상태가 “연동됨”으로 바뀝니다.',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _Steps(ColorScheme cs) {
    Widget step(String n, String title, String desc) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.surface.withOpacity(0.55),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: cs.outlineVariant.withOpacity(0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: cs.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        n,
                        style: TextStyle(
                          color: cs.onSecondary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(title,
                      style: TextStyle(
                        color: cs.secondary,
                        fontWeight: FontWeight.w900,
                      )),
                ],
              ),
              const SizedBox(height: 10),
              Text(desc, style: TextStyle(color: cs.onSurface)),
            ],
          ),
        ),
      );
    }

    return Row(
      children: [
        step('1', '카카오 로그인', '본인 계정으로 로그인해요.'),
        const SizedBox(width: 12),
        step('2', '키 발급', '버튼을 눌러 1분짜리 키를 생성해요.'),
        const SizedBox(width: 12),
        step('3', '카카오톡에 입력', '봇 대화창에 /link 6자리코드를 입력해요.'),
      ],
    );
  }

  Widget _KeyBox(ColorScheme cs) {
    final text = (hasCode && !expired) ? linkCode! : '— — — — — —';
    return Container(
      width: 520,
      height: 76,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outline, width: 2),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: cs.secondary,
          fontSize: 28,
          fontWeight: FontWeight.w900,
          letterSpacing: 2,
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.primary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant.withOpacity(0.15)),
      ),
      child: child,
    );
  }
}
