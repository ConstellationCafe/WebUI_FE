import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/feature/modules/erp/point/domain/model/point_member_detail.dart';
import 'package:constellation_cafe/feature/modules/erp/point/domain/model/point_member_page.dart';
import 'package:constellation_cafe/feature/modules/erp/point/notifier/admin_point_notifier.dart';

import 'support/fake_admin_point_repository.dart';

void main() {
  late FakeAdminPointRepository repository;
  late ProviderContainer container;
  late AdminPointNotifier notifier;

  setUp(() async {
    repository = FakeAdminPointRepository();
    container = ProviderContainer(
      overrides: [adminPointRepositoryProvider.overrideWithValue(repository)],
    );
    container.listen(adminPointProvider, (_, _) {});
    notifier = container.read(adminPointProvider.notifier);
    await Future<void>.delayed(Duration.zero);
  });

  tearDown(() => container.dispose());

  test('화면을 열면 회원 목록을 불러온다', () {
    final state = container.read(adminPointProvider);
    expect(state.isLoadingMembers, isFalse);
    expect(state.members.single.discordId, '123');
  });

  test('입력 중에는 검색하지 않고 제출한 검색어로 페이지를 이동한다', () async {
    final queries = <String?>[];
    repository.membersHandler = (page, search) async {
      queries.add(search);
      return PointMemberPage(
        items: [pointMember('456')],
        page: page,
        totalPages: 2,
      );
    };
    notifier.updateSearchInput(' 456 ');
    expect(container.read(adminPointProvider).searchInput, ' 456 ');
    expect(queries, isEmpty);
    await notifier.searchMembers();
    notifier.updateSearchInput('789');
    await notifier.loadMembers(page: 2);
    expect(queries, ['456', '456']);
    expect(container.read(adminPointProvider).search, '456');
    expect(container.read(adminPointProvider).searchInput, '789');
    expect(container.read(adminPointProvider).memberPage, 2);
  });

  test('검색 응답이 역순으로 와도 최근 검색 결과를 유지한다', () async {
    final older = Completer<PointMemberPage>();
    final latest = Completer<PointMemberPage>();
    repository.membersHandler = (_, search) =>
        search == '1' ? older.future : latest.future;
    final first = notifier.loadMembers(search: '1');
    final second = notifier.loadMembers(search: '2');
    latest.complete(
      PointMemberPage(items: [pointMember('2')], page: 1, totalPages: 1),
    );
    await second;
    older.complete(
      PointMemberPage(items: [pointMember('1')], page: 1, totalPages: 1),
    );
    await first;
    expect(container.read(adminPointProvider).members.single.discordId, '2');
    expect(container.read(adminPointProvider).search, '2');
  });

  test('이전 회원 조회 실패가 현재 선택을 덮어쓰지 않는다', () async {
    final older = Completer<PointMemberDetail>();
    repository.detailHandler = (id, _) =>
        id == '1' ? older.future : Future.value(pointDetail(id));
    final first = notifier.selectMember('1');
    await notifier.selectMember('2');
    older.completeError(StateError('old request'));
    await first;
    final state = container.read(adminPointProvider);
    expect(state.selected?.member.discordId, '2');
    expect(state.hasDetailError, isFalse);
  });

  test('회원 조회 실패 후 다른 회원에게 입출금할 수 없다', () async {
    await notifier.selectMember('1');
    repository.detailHandler = (_, _) =>
        Future.error(StateError('unavailable'));
    await notifier.selectMember('2');
    expect(container.read(adminPointProvider).selected, isNull);
    expect(container.read(adminPointProvider).hasDetailError, isTrue);
    expect(
      await notifier.transact(
        discordId: '1',
        isDeposit: true,
        amount: 10,
        description: '지급',
      ),
      isFalse,
    );
    expect(repository.transactionCount, 0);
  });

  test('입출금 처리 중 중복 요청과 회원 변경을 막고 잔액을 갱신한다', () async {
    await notifier.selectMember('123');
    final pending = Completer<PointMemberDetail>();
    repository.transactionHandler = (id, deposit, amount, description) {
      expect(id, '123');
      expect(deposit, isTrue);
      expect(amount, 500);
      expect(description, '이벤트 지급');
      return pending.future;
    };
    final transaction = notifier.transact(
      discordId: '123',
      isDeposit: true,
      amount: 500,
      description: '이벤트 지급',
    );
    expect(
      await notifier.transact(
        discordId: '123',
        isDeposit: true,
        amount: 500,
        description: '이벤트 지급',
      ),
      isFalse,
    );
    await notifier.selectMember('456');
    expect(
      container.read(adminPointProvider).selected?.member.discordId,
      '123',
    );
    pending.complete(pointDetail('123', coin: 1700));
    expect(await transaction, isTrue);
    expect(repository.transactionCount, 1);
    expect(container.read(adminPointProvider).selected?.member.coin, 1700);
    expect(container.read(adminPointProvider).isSubmitting, isFalse);
  });

  test('입출금 실패 시 제출 상태를 해제하고 기존 잔액을 유지한다', () async {
    await notifier.selectMember('123');
    repository.transactionHandler = (_, _, _, _) =>
        Future.error(StateError('failed'));
    expect(
      await notifier.transact(
        discordId: '123',
        isDeposit: false,
        amount: 500,
        description: '차감',
      ),
      isFalse,
    );
    expect(container.read(adminPointProvider).isSubmitting, isFalse);
    expect(container.read(adminPointProvider).selected?.member.coin, 1200);
  });

  test('화면을 닫은 뒤 완료되는 요청은 폐기된 상태를 수정하지 않는다', () async {
    final pending = Completer<PointMemberDetail>();
    repository.detailHandler = (_, _) => pending.future;
    final selection = notifier.selectMember('123');
    container.dispose();
    pending.complete(pointDetail('123'));
    await expectLater(selection, completes);
  });
}
