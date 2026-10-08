import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/feature/modules/erp/penalty/data/dto/request/penalty_create_request.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/data/repository/penalty_repository.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/domain/model/penalty_detail.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/domain/model/penalty_log.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/domain/model/penalty_member.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/domain/model/penalty_page.dart';

PenaltyLog exampleLog({int score = 2}) => PenaltyLog(
  id: 42,
  channelId: '999',
  channelName: '자유채팅',
  targetDiscordId: '123',
  targetUsername: '별',
  reason: '도배',
  score: 1,
  issuerDiscordId: '900',
  occurredAt: DateTime.utc(2026, 9, 28),
  createdAt: DateTime.utc(2026, 9, 28),
  isCanceled: false,
  targetCumulativeScore30d: score,
  canceledByDiscordId: null,
  canceledAt: null,
  cancellationReason: null,
);

PenaltyDetail exampleDetail(String discordId) => PenaltyDetail(
  discordId: discordId,
  username: '별',
  state: '재적',
  cumulativeScore30d: 2,
  history: PenaltyPage(
    items: [exampleLog()],
    page: 1,
    size: 20,
    totalElements: 1,
    totalPages: 1,
    hasNext: false,
  ),
);

class FakePenaltyRepository extends Fake implements PenaltyRepository {
  Future<PenaltyPage<PenaltyLog>> Function(String?, String?, int)?
  historyHandler;
  Future<PenaltyPage<PenaltyMember>> Function(String?, int)? membersHandler;
  Future<PenaltyDetail> Function(String, int)? memberHandler;
  Future<PenaltyDetail> Function(PenaltyCreateRequest)? awardHandler;
  Future<PenaltyDetail> Function(int, String)? cancelHandler;
  int awards = 0;
  bool manager = false;
  int permissionCalls = 0;
  Object? permissionError;
  Future<bool>? pendingPermission;

  @override
  Future<bool> isManager() async {
    permissionCalls++;
    final error = permissionError;
    if (error != null) throw error;
    return pendingPermission ?? manager;
  }

  @override
  Future<PenaltyPage<PenaltyLog>> history({
    String? channelId,
    String? discordId,
    String sort = 'OCCURRED_AT_DESC',
    int page = 1,
    CancelToken? cancelToken,
  }) async => historyHandler != null
      ? historyHandler!(channelId, discordId, page)
      : PenaltyPage(
          items: [exampleLog()],
          page: page,
          size: 20,
          totalElements: 1,
          totalPages: 1,
          hasNext: false,
        );

  @override
  Future<PenaltyPage<PenaltyMember>> members({
    String? discordId,
    int page = 1,
    CancelToken? cancelToken,
  }) async => membersHandler != null
      ? membersHandler!(discordId, page)
      : PenaltyPage(
          items: [
            PenaltyMember(
              discordId: '123',
              username: '별',
              cumulativeScore30d: 2,
              penaltyCount30d: 2,
              lastOccurredAt: DateTime.utc(2026, 9, 28),
            ),
          ],
          page: page,
          size: 20,
          totalElements: 1,
          totalPages: 1,
          hasNext: false,
        );

  @override
  Future<PenaltyDetail> member(
    String discordId, {
    int page = 1,
    CancelToken? cancelToken,
  }) async => memberHandler != null
      ? memberHandler!(discordId, page)
      : exampleDetail(discordId);

  @override
  Future<PenaltyDetail> award(PenaltyCreateRequest request) async {
    awards++;
    return awardHandler != null
        ? awardHandler!(request)
        : exampleDetail(request.targetDiscordId);
  }

  @override
  Future<PenaltyDetail> cancel(int penaltyId, String reason) async =>
      cancelHandler != null
      ? cancelHandler!(penaltyId, reason)
      : exampleDetail('123');
}
