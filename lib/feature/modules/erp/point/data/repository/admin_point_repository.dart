import '../../domain/model/point_log.dart';
import '../../domain/model/point_member.dart';
import '../../domain/model/point_member_detail.dart';
import '../../domain/model/point_member_page.dart';
import '../../domain/type/point_transaction_type.dart';
import '../api/admin_point_api.dart';
import '../dto/request/admin_point_history_request.dart';
import '../dto/request/admin_point_members_request.dart';
import '../dto/request/admin_point_transaction_request.dart';
import '../dto/response/admin_point_detail_response.dart';
import '../dto/response/admin_point_member_response.dart';

class AdminPointRepository {
  final AdminPointApi api;

  const AdminPointRepository({required this.api});

  Future<PointMemberPage> getMembers({
    required int page,
    int size = 20,
    String? discordId,
  }) async {
    final response = await api.getMembers(
      AdminPointMembersRequest(page: page, size: size, discordId: discordId),
    );
    return PointMemberPage(
      items: response.items.map(_member).toList(),
      page: response.page,
      totalPages: response.totalPages,
    );
  }

  Future<PointMemberDetail> getMember(String discordId, {int page = 1}) async {
    return _detail(
      await api.getMember(
        discordId,
        AdminPointHistoryRequest(page: page, size: 20),
      ),
    );
  }

  Future<PointMemberDetail> transact({
    required String discordId,
    required bool isDeposit,
    required int amount,
    required String description,
  }) async {
    return _detail(
      await api.transact(
        discordId,
        AdminPointTransactionRequest(
          type: isDeposit
              ? PointTransactionType.deposit
              : PointTransactionType.withdraw,
          amount: amount,
          description: description,
        ),
      ),
    );
  }

  PointMemberDetail _detail(AdminPointDetailResponse response) {
    return PointMemberDetail(
      member: PointMember(
        discordId: response.discordId,
        username: response.username ?? '',
        state: response.state,
        coin: response.coin,
      ),
      logs: response.logs
          .map(
            (log) => PointLog(
              amount: log.amount,
              at: log.at,
              description: log.description ?? '',
            ),
          )
          .toList(),
      page: response.page,
      totalPages: response.totalPages,
    );
  }

  PointMember _member(AdminPointMemberResponse response) {
    return PointMember(
      discordId: response.discordId,
      username: response.username ?? '',
      state: response.state,
      coin: response.coin,
    );
  }
}
