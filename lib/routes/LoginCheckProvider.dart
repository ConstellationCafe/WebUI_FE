import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/di/ApiProvider.dart';
import 'package:constellation_cafe/data/model/response/backend/ApiResponse.dart';


final loginCheckProvider = FutureProvider<bool>((ref) async {
  final jwt = ref.read(jwtApiProvider);

  bool parseIsLogin(ApiResponse api) {
    final resp = api.response as Map<String, dynamic>?;
    return resp?['isLogin'] == true;
  }

  bool parseRefreshHint(ApiResponse api) {
    final resp = api.response as Map<String, dynamic>?;
    return resp?['refreshHint'] == true;
  }

  bool isUnauthorized(ApiResponse api) {
    final s = api.error?.status;
    return s == 401 || s == 403;
  }

  try {
    final res = await jwt.check();

    // 1) /check 자체가 성공적으로 응답됨: isLogin 그대로 반환
    if (res.success == true) {
      final isLogin = parseIsLogin(res);
      if (isLogin) return true;

      // 로그인 false인 경우에만 hint를 보고 refresh 시도 여부 결정
      final hint = parseRefreshHint(res);
      if (!hint) return false;

      final refreshRes = await jwt.refresh();
      if (refreshRes != true) return false;

      final res2 = await jwt.check();
      return res2.success == true && parseIsLogin(res2);
    }

    // 2) /check가 인증 오류로 실패한 경우(만료/무효 등) → refresh 시도
    if (isUnauthorized(res)) {
      final refreshRes = await jwt.refresh();
      if (refreshRes != true) return false;

      final res2 = await jwt.check();
      return res2.success == true && parseIsLogin(res2);
    }

    // 3) 그 외 실패는 로그인 아님
    return false;

  } catch (_) {
    return false;
  }
});