import '../../domain/point_log.dart';
import '../../domain/point_member.dart';
import '../../domain/point_member_detail.dart';
import '../../domain/point_page.dart';
import '../api/point_management_api.dart';

class PointManagementRepository {
  final PointManagementApi api;

  const PointManagementRepository({required this.api});

  Future<PointPage<PointMember>> getMembers({
    required String discordId,
    required int page,
    int size = 20,
  }) async {
    final data = await api.getMembers(
      discordId: discordId,
      page: page,
      size: size,
    );
    final rawMembers = data['members'];
    final members = rawMembers is List
        ? rawMembers
              .whereType<Map>()
              .map((row) => _mapMember(Map<String, dynamic>.from(row)))
              .toList()
        : <PointMember>[];
    return PointPage<PointMember>(
      items: members,
      page: _asInt(data['page'], page),
      size: _asInt(data['size'], size),
      totalElements: _asInt(data['totalElements'], members.length),
      totalPages: _asInt(data['totalPages'], 0),
      hasNext: data['hasNext'] == true,
    );
  }

  Future<PointMemberDetail> getMemberDetail({
    required String discordId,
    required int page,
    int size = 20,
  }) async {
    final data = await api.getMemberDetail(
      discordId: discordId,
      page: page,
      size: size,
    );
    final rawMember = data['member'];
    if (rawMember is! Map) {
      throw const FormatException('선택한 회원 정보가 응답에 없습니다.');
    }
    final rawLogs = data['logs'];
    final logs = rawLogs is List
        ? rawLogs
              .whereType<Map>()
              .map((row) => _mapLog(Map<String, dynamic>.from(row)))
              .toList()
        : <PointLog>[];
    return PointMemberDetail(
      member: _mapMember(Map<String, dynamic>.from(rawMember)),
      logs: PointPage<PointLog>(
        items: logs,
        page: _asInt(data['page'], page),
        size: _asInt(data['size'], size),
        totalElements: _asInt(data['totalElements'], logs.length),
        totalPages: _asInt(data['totalPages'], 0),
        hasNext: data['hasNext'] == true,
      ),
    );
  }

  Future<void> adjustPoint({
    required String discordId,
    required String type,
    required int amount,
    required String description,
  }) async {
    await api.adjustPoint(
      discordId: discordId,
      type: type,
      amount: amount,
      description: description,
    );
  }

  PointMember _mapMember(Map<String, dynamic> row) => PointMember(
    discordId: row['discordId']?.toString() ?? '',
    username: row['username']?.toString() ?? '이름 없음',
    coin: _asInt(row['coin'], 0),
  );

  PointLog _mapLog(Map<String, dynamic> row) => PointLog(
    amount: _asInt(row['amount'], 0),
    at: row['at']?.toString() ?? '',
    description: row['description']?.toString() ?? '',
  );

  int _asInt(dynamic value, int fallback) =>
      value is num ? value.toInt() : int.tryParse(value?.toString() ?? '') ?? fallback;
}
