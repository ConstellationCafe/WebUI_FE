import 'package:constellation_cafe/feature/modules/erp/point/data/api/point_management_api.dart';
import 'package:constellation_cafe/feature/modules/erp/point/data/repository/point_management_repository.dart';
import 'package:constellation_cafe/feature/modules/erp/point/domain/point_log.dart';
import 'package:constellation_cafe/feature/modules/erp/point/domain/point_member.dart';
import 'package:constellation_cafe/feature/modules/erp/point/domain/point_member_detail.dart';
import 'package:constellation_cafe/feature/modules/erp/point/domain/point_page.dart';
import 'package:dio/dio.dart';

class FakePointManagementRepository extends PointManagementRepository {
  FakePointManagementRepository() : super(api: PointManagementApi(dio: Dio()));

  final member = const PointMember(
    discordId: '123',
    username: 'Mina',
    coin: 1250,
  );
  String? lastType;
  int? lastAmount;
  String? lastDescription;

  @override
  Future<PointPage<PointMember>> getMembers({
    required String discordId,
    required int page,
    int size = 20,
  }) async {
    final items = discordId.isEmpty || discordId == member.discordId
        ? [member]
        : <PointMember>[];
    return PointPage<PointMember>(
      items: items,
      page: page,
      size: size,
      totalElements: items.length,
      totalPages: items.isEmpty ? 0 : 1,
      hasNext: false,
    );
  }

  @override
  Future<PointMemberDetail> getMemberDetail({
    required String discordId,
    required int page,
    int size = 20,
  }) async {
    return PointMemberDetail(
      member: member,
      logs: PointPage<PointLog>(
        items: const [
          PointLog(
            amount: 250,
            at: '2026-09-23T10:00:00',
            description: 'monthly reward',
          ),
        ],
        page: page,
        size: size,
        totalElements: 1,
        totalPages: 1,
        hasNext: false,
      ),
    );
  }

  @override
  Future<void> adjustPoint({
    required String discordId,
    required String type,
    required int amount,
    required String description,
  }) async {
    lastType = type;
    lastAmount = amount;
    lastDescription = description;
  }
}
