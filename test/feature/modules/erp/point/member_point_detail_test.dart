import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/feature/modules/erp/point/domain/model/point_log.dart';
import 'package:constellation_cafe/feature/modules/erp/point/domain/model/point_member.dart';
import 'package:constellation_cafe/feature/modules/erp/point/domain/model/point_member_detail.dart';
import 'package:constellation_cafe/feature/modules/erp/point/widgets/member_point_detail.dart';

void main() {
  testWidgets('선택한 회원의 잔액과 포인트 내역을 표시한다', (tester) async {
    final detail = PointMemberDetail(
      member: const PointMember(
        discordId: '123456789',
        username: '별자리',
        state: '재적',
        coin: 1200,
      ),
      logs: [
        PointLog(
          amount: 500,
          at: DateTime.utc(2026, 9, 23, 1),
          description: '이벤트 지급',
        ),
      ],
      page: 1,
      totalPages: 1,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 800,
            height: 700,
            child: MemberPointDetail(
              detail: detail,
              isLoading: false,
              onDeposit: () {},
              onWithdraw: () {},
              onPageChanged: (_) {},
            ),
          ),
        ),
      ),
    );

    expect(find.text('별자리'), findsOneWidget);
    expect(find.textContaining('1,200'), findsOneWidget);
    expect(find.text('이벤트 지급'), findsOneWidget);
    expect(find.text('입금'), findsOneWidget);
    expect(find.text('출금'), findsOneWidget);
  });

  testWidgets('선택 전 안내를 표시한다', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MemberPointDetail(
          detail: null,
          isLoading: false,
          onDeposit: () {},
          onWithdraw: () {},
          onPageChanged: (_) {},
        ),
      ),
    );

    expect(find.textContaining('회원을 선택하면'), findsOneWidget);
  });
}
