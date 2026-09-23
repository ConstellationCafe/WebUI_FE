import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

typedef _PointLog = ({int amount, String at, String description, bool deposit});
typedef _PointMember = ({String username, String discordId, int coin, List<_PointLog> logs});

const _navy = Color(0xFF000D27);
const _muted = Color(0xFF687385);
const _line = Color(0xFFE6EAF0);
const _green = Color(0xFF16845B);
const _red = Color(0xFFC14343);
final _numberFormat = NumberFormat.decimalPattern('ko_KR');

final List<_PointMember> _mockMembers = [
  (username: '별빛고래', discordId: '847362910284736512', coin: 18200, logs: [
    (amount: 1200, at: '2026.09.22 21:32', description: '친선전 참여 보상', deposit: true),
    (amount: 500, at: '2026.09.20 18:05', description: '카페 이벤트 사용', deposit: false),
    (amount: 2000, at: '2026.09.18 20:14', description: '주간 활동 보상', deposit: true),
  ]),
  (username: '모카라떼', discordId: '926184730519284736', coin: 7450, logs: [
    (amount: 450, at: '2026.09.21 19:42', description: '출석 체크 보상', deposit: true),
    (amount: 1000, at: '2026.09.19 17:10', description: '대회 참가 신청', deposit: false),
  ]),
  (username: '달토끼', discordId: '735091826473501928', coin: 32100, logs: [
    (amount: 3000, at: '2026.09.22 12:01', description: '운영진 지급', deposit: true),
    (amount: 900, at: '2026.09.17 22:30', description: '추천 메뉴 교환', deposit: false),
  ]),
  (username: '푸른새벽', discordId: '684203917562840193', coin: 0, logs: []),
  (username: '카페라온', discordId: '519283746102938475', coin: 12800, logs: [
    (amount: 800, at: '2026.09.22 09:20', description: '출석 체크 보상', deposit: true),
  ]),
  (username: '하늘정원', discordId: '402938475610293847', coin: 5600, logs: [
    (amount: 600, at: '2026.09.21 14:08', description: '게시글 작성 보상', deposit: true),
  ]),
  (username: '밤의산책', discordId: '391827465019283746', coin: 9300, logs: [
    (amount: 700, at: '2026.09.20 11:51', description: '출석 체크 보상', deposit: true),
  ]),
  (username: '별자리수집가', discordId: '280193847561029384', coin: 21400, logs: [
    (amount: 1500, at: '2026.09.19 16:27', description: '이벤트 보상', deposit: true),
  ]),
];

class AdminPointPage extends StatefulWidget {
  const AdminPointPage({super.key});

  @override
  State<AdminPointPage> createState() => _AdminPointPageState();
}

class _AdminPointPageState extends State<AdminPointPage> {
  final _searchController = TextEditingController();
  final List<_PointMember> _members = List.of(_mockMembers);
  int _selectedIndex = 0;
  int _page = 0;
  static const _pageSize = 5;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }

  void _onSearchChanged() => setState(() => _page = 0);

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final filtered = _members.where((member) =>
        member.username.toLowerCase().contains(query) || member.discordId.contains(query)).toList();
    final pages = (filtered.length / _pageSize).ceil();
    final page = pages == 0 ? 0 : (_page >= pages ? pages - 1 : _page);
    final visible = filtered.skip(page * _pageSize).take(_pageSize).toList();
    final selected = _members[_selectedIndex];

    return LayoutBuilder(builder: (context, constraints) {
      final wide = constraints.maxWidth >= 900;
      final memberPanel = _buildMemberPanel(filtered, visible, page, pages);
      final details = _buildDetails(selected);
      return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1440),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              if (wide)
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(width: 330, child: memberPanel),
                  const SizedBox(width: 20),
                  Expanded(child: details),
                ])
              else ...[
                memberPanel,
                const SizedBox(height: 16),
                details,
              ],
            ]),
          ),
        ),
      );
    });
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Row(children: [
      Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(color: _navy, borderRadius: BorderRadius.circular(14)),
        child: const Icon(Icons.toll_rounded, color: Colors.white, size: 24),
      ),
      const SizedBox(width: 14),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('포인트 관리', style: theme.textTheme.headlineSmall?.copyWith(color: _navy, fontWeight: FontWeight.w700)),
        const SizedBox(height: 3),
        Text('재적 회원을 선택해 잔액과 포인트 기록을 확인하세요.', style: theme.textTheme.bodyMedium?.copyWith(color: _muted)),
      ])),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
        decoration: BoxDecoration(color: const Color(0xFFEAF5F0), borderRadius: BorderRadius.circular(20)),
        child: Text('목업 데이터', style: theme.textTheme.labelMedium?.copyWith(color: _green, fontWeight: FontWeight.w700)),
      ),
    ]);
  }

  Widget _buildMemberPanel(List<_PointMember> filtered, List<_PointMember> visible, int page, int pages) {
    final theme = Theme.of(context);
    return _panel(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(children: [
        Expanded(child: Text('회원 선택', style: theme.textTheme.titleMedium?.copyWith(color: _navy, fontWeight: FontWeight.w700))),
        Text(filtered.length.toString() + '명', style: theme.textTheme.labelMedium?.copyWith(color: _muted)),
      ]),
      const SizedBox(height: 14),
      TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Discord ID 또는 사용자명 검색',
          prefixIcon: const Icon(Icons.search_rounded, size: 20),
          suffixIcon: _searchController.text.isEmpty ? null : IconButton(
            tooltip: '검색어 지우기', onPressed: _searchController.clear, icon: const Icon(Icons.close_rounded, size: 18)),
          filled: true,
          fillColor: const Color(0xFFF7F8FA),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        ),
      ),
      const SizedBox(height: 12),
      if (visible.isEmpty)
        Padding(padding: const EdgeInsets.symmetric(vertical: 32), child: Column(children: [
          const Icon(Icons.person_search_rounded, color: _muted, size: 30),
          const SizedBox(height: 8),
          Text('검색 결과가 없습니다.', style: theme.textTheme.bodyMedium?.copyWith(color: _muted)),
        ]))
      else
        ...visible.map((member) {
          final index = _members.indexOf(member);
          final selected = index == _selectedIndex;
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Material(
              color: selected ? const Color(0xFFF0F3F8) : Colors.white,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => setState(() => _selectedIndex = index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: selected ? _navy : _line)),
                  child: Row(children: [
                    CircleAvatar(radius: 18, backgroundColor: selected ? _navy : const Color(0xFFE8ECF2),
                      child: Text(member.username.substring(0, 1), style: TextStyle(color: selected ? Colors.white : _navy, fontWeight: FontWeight.w700))),
                    const SizedBox(width: 10),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(member.username, maxLines: 1, overflow: TextOverflow.ellipsis, style: theme.textTheme.bodyMedium?.copyWith(color: const Color(0xFF1A1A1E), fontWeight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      Text(member.discordId, maxLines: 1, overflow: TextOverflow.ellipsis, style: theme.textTheme.bodySmall?.copyWith(color: _muted)),
                    ])),
                    if (selected) const Icon(Icons.check_circle_rounded, color: _navy, size: 18),
                  ]),
                ),
              ),
            ),
          );
        }),
      if (pages > 1) ...[
        const SizedBox(height: 6),
        const Divider(height: 1, color: _line),
        const SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          TextButton.icon(onPressed: page > 0 ? () => setState(() => _page = page - 1) : null,
            icon: const Icon(Icons.chevron_left_rounded, size: 18), label: const Text('이전')),
          Text((page + 1).toString() + ' / ' + pages.toString(), style: theme.textTheme.labelMedium?.copyWith(color: _muted)),
          TextButton(onPressed: page + 1 < pages ? () => setState(() => _page = page + 1) : null,
            child: const Row(mainAxisSize: MainAxisSize.min, children: [Text('다음'), SizedBox(width: 4), Icon(Icons.chevron_right_rounded, size: 18)])),
        ]),
      ],
    ]));
  }

  Widget _buildDetails(_PointMember member) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    _buildBalance(member),
    const SizedBox(height: 16),
    _buildHistory(member),
  ]);

  Widget _buildBalance(_PointMember member) {
    final theme = Theme.of(context);
    return _panel(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(children: [
        CircleAvatar(radius: 23, backgroundColor: const Color(0xFFE8ECF2),
          child: Text(member.username.substring(0, 1), style: theme.textTheme.titleMedium?.copyWith(color: _navy, fontWeight: FontWeight.w700))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(member.username, style: theme.textTheme.titleMedium?.copyWith(color: _navy, fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text('Discord ID  ' + member.discordId, style: theme.textTheme.bodySmall?.copyWith(color: _muted)),
        ])),
        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(color: const Color(0xFFEAF5F0), borderRadius: BorderRadius.circular(18)),
          child: Text('재적', style: theme.textTheme.labelSmall?.copyWith(color: _green, fontWeight: FontWeight.w700))),
      ]),
      const SizedBox(height: 20),
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF142746), _navy], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(14)),
        child: Row(children: [
          Container(width: 42, height: 42, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.toll_rounded, color: Color(0xFFF4C95D))),
          const SizedBox(width: 13),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('보유 포인트', style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70)),
            const SizedBox(height: 4),
            Text(_numberFormat.format(member.coin) + ' P', style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
          ])),
          const SizedBox(width: 12),
          FilledButton.icon(onPressed: () => _showTransactionDialog(member, true), icon: const Icon(Icons.add_rounded, size: 18), label: const Text('입금'),
            style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: _navy)),
          const SizedBox(width: 8),
          OutlinedButton.icon(onPressed: () => _showTransactionDialog(member, false), icon: const Icon(Icons.remove_rounded, size: 18), label: const Text('출금'),
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: BorderSide(color: Colors.white.withValues(alpha: 0.65)))),
        ]),
      ),
    ]));
  }

  Widget _buildHistory(_PointMember member) {
    final theme = Theme.of(context);
    return _panel(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(children: [
        Expanded(child: Text('포인트 기록', style: theme.textTheme.titleMedium?.copyWith(color: _navy, fontWeight: FontWeight.w700))),
        Text('최근 ' + member.logs.length.toString() + '건', style: theme.textTheme.labelMedium?.copyWith(color: _muted)),
      ]),
      const SizedBox(height: 12),
      if (member.logs.isEmpty)
        Padding(padding: const EdgeInsets.symmetric(vertical: 34), child: Column(children: [
          const Icon(Icons.receipt_long_rounded, color: _muted, size: 30),
          const SizedBox(height: 8),
          Text('아직 포인트 기록이 없습니다.', style: theme.textTheme.bodyMedium?.copyWith(color: _muted)),
        ]))
      else
        ...member.logs.map((log) {
          final color = log.deposit ? _green : _red;
          return Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Row(children: [
            Container(width: 38, height: 38, decoration: BoxDecoration(color: log.deposit ? const Color(0xFFEAF5F0) : const Color(0xFFFCEEEE), borderRadius: BorderRadius.circular(11)),
              child: Icon(log.deposit ? Icons.south_west_rounded : Icons.north_east_rounded, color: color, size: 19)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(log.description, maxLines: 1, overflow: TextOverflow.ellipsis, style: theme.textTheme.bodyMedium?.copyWith(color: const Color(0xFF1A1A1E), fontWeight: FontWeight.w600)),
              const SizedBox(height: 3),
              Text(log.at, style: theme.textTheme.bodySmall?.copyWith(color: _muted)),
            ])),
            const SizedBox(width: 8),
            Text((log.deposit ? '+' : '−') + _numberFormat.format(log.amount) + ' P', style: theme.textTheme.bodyMedium?.copyWith(color: color, fontWeight: FontWeight.w700)),
          ]));
        }),
    ]));
  }

  Widget _panel({required Widget child}) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: _line),
      boxShadow: const [BoxShadow(color: Color(0x0A000D27), blurRadius: 18, offset: Offset(0, 6))]),
    child: child,
  );

  Future<void> _showTransactionDialog(_PointMember member, bool initialDeposit) async {
    final amountController = TextEditingController();
    final descriptionController = TextEditingController();
    var isDeposit = initialDeposit;
    final result = await showDialog<({bool deposit, int amount, String description})>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(builder: (context, setDialogState) => AlertDialog(
        title: Text(isDeposit ? '포인트 입금' : '포인트 출금'),
        content: SizedBox(width: 440, child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SegmentedButton<bool>(segments: const [
            ButtonSegment(value: true, label: Text('입금'), icon: Icon(Icons.add_rounded)),
            ButtonSegment(value: false, label: Text('출금'), icon: Icon(Icons.remove_rounded)),
          ], selected: {isDeposit}, onSelectionChanged: (selection) => setDialogState(() => isDeposit = selection.first)),
          const SizedBox(height: 18),
          TextField(controller: amountController, keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(labelText: '포인트', hintText: '지급 또는 차감할 포인트', suffixText: 'P')),
          const SizedBox(height: 12),
          TextField(controller: descriptionController, maxLength: 80, maxLines: 2,
            decoration: const InputDecoration(labelText: '내역', hintText: '예: 이벤트 참여 보상', alignLabelWithHint: true)),
          const SizedBox(height: 4),
          Text('대상: ' + member.username + ' · 현재 잔액 ' + _numberFormat.format(member.coin) + ' P',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: _muted)),
        ])),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('취소')),
          FilledButton(onPressed: () {
            final amount = int.tryParse(amountController.text);
            final description = descriptionController.text.trim();
            if (amount == null || amount <= 0 || description.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('포인트와 내역을 입력해 주세요.')));
              return;
            }
            if (!isDeposit && amount > member.coin) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('보유 포인트보다 많이 출금할 수 없습니다.')));
              return;
            }
            Navigator.pop(dialogContext, (deposit: isDeposit, amount: amount, description: description));
          }, child: Text(isDeposit ? '입금하기' : '출금하기')),
        ],
      )),
    );
    amountController.dispose();
    descriptionController.dispose();
    if (result == null || !mounted) return;

    final index = _selectedIndex;
    final selected = _members[index];
    final log = (amount: result.amount, at: DateFormat('yyyy.MM.dd HH:mm').format(DateTime.now()),
      description: result.description, deposit: result.deposit);
    setState(() {
      _members[index] = (username: selected.username, discordId: selected.discordId,
        coin: selected.coin + (result.deposit ? result.amount : -result.amount), logs: [log, ...selected.logs]);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result.deposit ? '포인트를 입금했습니다.' : '포인트를 출금했습니다.')));
  }
}
