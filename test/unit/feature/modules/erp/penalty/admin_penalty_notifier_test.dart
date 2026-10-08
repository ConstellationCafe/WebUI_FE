import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/feature/modules/erp/penalty/data/dto/request/penalty_create_request.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/data/repository/penalty_repository_provider.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/domain/model/penalty_detail.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/notifier/admin_penalty_notifier.dart';

import '../../../../../support/feature/modules/erp/penalty/support/fake_penalty_repository.dart';

void main() {
  late FakePenaltyRepository repository;
  late ProviderContainer container;
  late AdminPenaltyNotifier notifier;

  setUp(() async {
    repository = FakePenaltyRepository();
    container = ProviderContainer(
      overrides: [penaltyRepositoryProvider.overrideWithValue(repository)],
    );
    container.listen(adminPenaltyProvider, (_, _) {});
    notifier = container.read(adminPenaltyProvider.notifier);
    await Future<void>.delayed(Duration.zero);
  });

  tearDown(() => container.dispose());

  test('초기 조회와 필터, 대상 선택이 각자 페이지를 갱신한다', () async {
    expect(
      container
          .read(adminPenaltyProvider)
          .history
          ?.items
          .single
          .targetCumulativeScore30d,
      2,
    );
    await notifier.loadHistory(page: 1, channelId: '999', discordId: '123');
    await notifier.selectMember('123');
    final state = container.read(adminPenaltyProvider);
    expect(state.channelId, '999');
    expect(state.discordId, '123');
    expect(state.selected?.cumulativeScore30d, 2);
  });

  test('제출 중 중복 벌점 부여를 막는다', () async {
    final pending = Completer<PenaltyDetail>();
    repository.awardHandler = (_) => pending.future;
    const request = PenaltyCreateRequest(
      requestId: '3f2b8c1e-7b0c-4036-8a9d-29947cbe1691',
      targetDiscordId: '123',
      channelId: '999',
      reason: '도배',
    );
    final first = notifier.award(request);
    expect(await notifier.award(request), isFalse);
    expect(repository.awards, 1);
    pending.complete(exampleDetail('123'));
    expect(await first, isTrue);
    expect(container.read(adminPenaltyProvider).selectedId, '123');
  });

  test('조회 오류를 표시하고 새 조회로 복구한다', () async {
    repository.historyHandler = (_, __, ___) =>
        Future.error(StateError('offline'));
    await notifier.loadHistory();
    expect(container.read(adminPenaltyProvider).hasHistoryError, isTrue);
    repository.historyHandler = null;
    await notifier.loadHistory();
    expect(container.read(adminPenaltyProvider).hasHistoryError, isFalse);
  });
}
