import '../../domain/model/point_log.dart';
import '../../domain/model/point_member.dart';
import '../../domain/model/point_member_detail.dart';
import '../../domain/model/point_member_page.dart';
import '../api/admin_point_api.dart';

class AdminPointRepository {
  final AdminPointApi api;

  const AdminPointRepository({required this.api});

  Future<PointMemberPage> getMembers({
    required int page,
    int size = 20,
    String? discordId,
  }) async {
    final json = await api.getMembers(
      page: page,
      size: size,
      discordId: discordId,
    );
    final rawItems = json['items'] as List<dynamic>? ?? const [];
    return PointMemberPage(
      items: rawItems
          .map((item) => _member(Map<String, dynamic>.from(item as Map)))
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? page,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
    );
  }

  Future<PointMemberDetail> getMember(String discordId, {int page = 1}) async {
    return _detail(await api.getMember(discordId, page: page, size: 20));
  }

  Future<PointMemberDetail> transact({
    required String discordId,
    required bool isDeposit,
    required int amount,
    required String description,
  }) async {
    return _detail(
      await api.transact(
        discordId: discordId,
        isDeposit: isDeposit,
        amount: amount,
        description: description,
      ),
    );
  }

  PointMemberDetail _detail(Map<String, dynamic> json) {
    final rawLogs = json['logs'] as List<dynamic>? ?? const [];
    return PointMemberDetail(
      member: _member(json),
      logs: rawLogs.map((item) {
        final log = Map<String, dynamic>.from(item as Map);
        return PointLog(
          amount: (log['amount'] as num).toInt(),
          at: DateTime.parse(log['at'] as String),
          description: log['description'] as String? ?? '',
        );
      }).toList(),
      page: (json['page'] as num?)?.toInt() ?? 1,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
    );
  }

  PointMember _member(Map<String, dynamic> json) {
    return PointMember(
      discordId: json['discordId'] as String,
      username: json['username'] as String? ?? '',
      state: json['state'] as String,
      coin: (json['coin'] as num).toInt(),
    );
  }
}
