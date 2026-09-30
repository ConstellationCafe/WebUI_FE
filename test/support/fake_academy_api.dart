import 'package:dio/dio.dart';

import 'package:constellation_cafe/feature/modules/academy/data/api/academy_api.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/academy_permission.dart';

/// 위젯 테스트용 아카데미 API. Dio 없이 권한을 바로 돌려준다.
///
/// 위젯 테스트의 가짜 시간에서 네트워크 계층을 기다리지 않도록 한다.
class FakeAcademyApi extends AcademyApi {
  FakeAcademyApi() : super(dio: Dio());

  AcademyPermission permission = AcademyPermission.initial();
  int permissionCalls = 0;
  Object? permissionError;
  Future<AcademyPermission>? pendingPermission;

  @override
  Future<AcademyPermission> getMyPermissions() async {
    permissionCalls++;
    final error = permissionError;
    if (error != null) throw error;
    return pendingPermission ?? permission;
  }
}
