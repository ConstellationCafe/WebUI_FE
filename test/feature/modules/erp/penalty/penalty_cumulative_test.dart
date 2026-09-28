import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/feature/modules/erp/penalty/domain/calculate_penalty_cumulative.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/domain/model/penalty_log.dart';

PenaltyLog penaltyLog({
  required int id,
  required String targetDiscordId,
  required int targetCumulativeScore30d,
}) => PenaltyLog(
  id: id,
  channelId: '999',
  channelName: '자유채팅',
  targetDiscordId: targetDiscordId,
  targetUsername: '별',
  reason: '도배',
  score: 1,
  issuerDiscordId: '900',
  occurredAt: DateTime.utc(2026, 9, 28),
  createdAt: DateTime.utc(2026, 9, 28),
  isCanceled: false,
  targetCumulativeScore30d: targetCumulativeScore30d,
  canceledByDiscordId: null,
  canceledAt: null,
  cancellationReason: null,
);

void main() {
  test('최신순 이력은 각 대상자의 누적 점수를 벌점 시점에 맞춰 계산한다', () {
    final scores = cumulativeScoresForLogs(
      logs: [
        penaltyLog(id: 2, targetDiscordId: '123', targetCumulativeScore30d: 2),
        penaltyLog(id: 1, targetDiscordId: '123', targetCumulativeScore30d: 2),
      ],
      newestFirst: true,
    );

    expect(scores, [2, 1]);
  });

  test('대상이 여러 명이어도 누적 점수를 대상자별로 분리한다', () {
    final scores = cumulativeScoresForLogs(
      logs: [
        penaltyLog(id: 1, targetDiscordId: '123', targetCumulativeScore30d: 2),
        penaltyLog(id: 2, targetDiscordId: '456', targetCumulativeScore30d: 1),
        penaltyLog(id: 3, targetDiscordId: '123', targetCumulativeScore30d: 2),
      ],
      newestFirst: false,
    );

    expect(scores, [1, 1, 2]);
  });
}
