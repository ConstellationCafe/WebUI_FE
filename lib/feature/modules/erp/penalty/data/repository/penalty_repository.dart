import 'package:dio/dio.dart';

import '../../domain/model/penalty_detail.dart';
import '../../domain/model/penalty_log.dart';
import '../../domain/model/penalty_member.dart';
import '../../domain/model/penalty_page.dart';
import '../../domain/type/penalty_history_sort.dart';
import '../api/penalty_api.dart';
import '../dto/request/penalty_cancel_request.dart';
import '../dto/request/penalty_create_request.dart';
import '../dto/request/penalty_history_request.dart';
import '../dto/request/penalty_members_request.dart';
import '../dto/request/penalty_page_request.dart';
import '../dto/response/penalty_detail_response.dart';
import '../dto/response/penalty_history_response.dart';
import '../dto/response/penalty_member_response.dart';
import '../dto/response/penalty_page_response.dart';

class PenaltyRepository {
  final PenaltyApi api;

  const PenaltyRepository({required this.api});

  /// 벌점 관리 기능을 쓸 수 있는지. 조회에 실패하면 예외를 그대로 던져 notifier가 권한 없음으로 처리한다.
  Future<bool> isManager() async => (await api.permission()).manager;

  Future<PenaltyPage<PenaltyLog>> history({
    String? channelId,
    String? discordId,
    String sort = PenaltyHistorySort.newest,
    int page = 1,
    CancelToken? cancelToken,
  }) async => _page(
    await api.history(
      PenaltyHistoryRequest(
        channelId: channelId,
        discordId: discordId,
        sort: sort,
        page: page,
      ),
      cancelToken: cancelToken,
    ),
    _log,
  );

  Future<PenaltyPage<PenaltyMember>> members({
    String? discordId,
    int page = 1,
    CancelToken? cancelToken,
  }) async => _page(
    await api.members(
      PenaltyMembersRequest(discordId: discordId, page: page),
      cancelToken: cancelToken,
    ),
    _member,
  );

  Future<PenaltyDetail> member(
    String discordId, {
    int page = 1,
    CancelToken? cancelToken,
  }) async => _detail(
    await api.member(
      discordId,
      PenaltyPageRequest(page: page),
      cancelToken: cancelToken,
    ),
  );

  Future<PenaltyDetail> mine({int page = 1, CancelToken? cancelToken}) async =>
      _detail(
        await api.mine(
          PenaltyPageRequest(page: page),
          cancelToken: cancelToken,
        ),
      );

  Future<PenaltyDetail> award(PenaltyCreateRequest request) async =>
      _detail(await api.award(request));

  Future<PenaltyDetail> cancel(int penaltyId, String reason) async => _detail(
    await api.cancel(penaltyId, PenaltyCancelRequest(reason: reason)),
  );

  PenaltyPage<R> _page<T, R>(
    PenaltyPageResponse<T> response,
    R Function(T) convert,
  ) => PenaltyPage(
    items: response.items.map(convert).toList(),
    page: response.page,
    size: response.size,
    totalElements: response.totalElements,
    totalPages: response.totalPages,
    hasNext: response.hasNext,
  );

  PenaltyDetail _detail(PenaltyDetailResponse response) => PenaltyDetail(
    discordId: response.discordId,
    username: response.username,
    state: response.state,
    cumulativeScore30d: response.cumulativeScore30d,
    history: _page(response.history, _log),
  );

  PenaltyMember _member(PenaltyMemberResponse response) => PenaltyMember(
    discordId: response.discordId,
    username: response.username,
    cumulativeScore30d: response.cumulativeScore30d,
    penaltyCount30d: response.penaltyCount30d,
    lastOccurredAt: response.lastOccurredAt,
  );

  PenaltyLog _log(PenaltyHistoryResponse response) => PenaltyLog(
    id: response.penaltyId,
    channelId: response.channelId,
    channelName: response.channelName,
    targetDiscordId: response.targetDiscordId,
    targetUsername: response.targetUsername,
    reason: response.reason,
    score: response.score,
    issuerDiscordId: response.issuerDiscordId,
    occurredAt: response.occurredAt,
    createdAt: response.createdAt,
    isCanceled: response.status == 'CANCELED',
    targetCumulativeScore30d: response.targetCumulativeScore30d,
    canceledByDiscordId: response.canceledByDiscordId,
    canceledAt: response.canceledAt,
    cancellationReason: response.cancellationReason,
  );
}
