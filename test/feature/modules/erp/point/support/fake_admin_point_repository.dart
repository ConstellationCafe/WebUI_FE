import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/feature/modules/erp/point/data/repository/admin_point_repository.dart';
import 'package:constellation_cafe/feature/modules/erp/point/domain/model/point_log.dart';
import 'package:constellation_cafe/feature/modules/erp/point/domain/model/point_member.dart';
import 'package:constellation_cafe/feature/modules/erp/point/domain/model/point_member_detail.dart';
import 'package:constellation_cafe/feature/modules/erp/point/domain/model/point_member_page.dart';

PointMember pointMember(String discordId, {int coin = 1200}) =>
    PointMember(discordId: discordId, username: '별자리', state: '재적', coin: coin);

PointMemberDetail pointDetail(String discordId, {int coin = 1200}) =>
    PointMemberDetail(
      member: pointMember(discordId, coin: coin),
      logs: const [],
      page: 1,
      totalPages: 0,
    );

class FakeAdminPointRepository extends Fake implements AdminPointRepository {
  Future<PointMemberPage> Function(int page, String? search)? membersHandler;
  Future<PointMemberDetail> Function(String discordId, int page)? detailHandler;
  Future<PointMemberDetail> Function(
    String discordId,
    bool isDeposit,
    int amount,
    String description,
  )?
  transactionHandler;
  Future<PointMemberDetail> Function(
    String discordId,
    PointLog log,
    int amount,
    String description,
  )?
  updateHandler;
  Future<PointMemberDetail> Function(String discordId, PointLog log)?
  deleteHandler;
  int transactionCount = 0;
  int updateCount = 0;
  int deleteCount = 0;

  @override
  Future<PointMemberPage> getMembers({
    required int page,
    int size = 20,
    String? discordId,
  }) async {
    return membersHandler != null
        ? membersHandler!(page, discordId)
        : PointMemberPage(
            items: [pointMember('123')],
            page: page,
            totalPages: 1,
          );
  }

  @override
  Future<PointMemberDetail> getMember(String discordId, {int page = 1}) async {
    return detailHandler != null
        ? detailHandler!(discordId, page)
        : pointDetail(discordId);
  }

  @override
  Future<PointMemberDetail> transact({
    required String discordId,
    required bool isDeposit,
    required int amount,
    required String description,
  }) async {
    transactionCount++;
    return transactionHandler != null
        ? transactionHandler!(discordId, isDeposit, amount, description)
        : pointDetail(
            discordId,
            coin: isDeposit ? 1200 + amount : 1200 - amount,
          );
  }

  @override
  Future<PointMemberDetail> updateLog({
    required String discordId,
    required PointLog log,
    required int amount,
    required String description,
  }) async {
    updateCount++;
    return updateHandler != null
        ? updateHandler!(discordId, log, amount, description)
        : pointDetail(discordId);
  }

  @override
  Future<PointMemberDetail> deleteLog({
    required String discordId,
    required PointLog log,
  }) async {
    deleteCount++;
    return deleteHandler != null
        ? deleteHandler!(discordId, log)
        : pointDetail(discordId);
  }
}
