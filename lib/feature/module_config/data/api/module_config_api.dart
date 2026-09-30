import 'package:dio/dio.dart';

import 'package:constellation_cafe/core/network/interceptors/error_interceptor.dart';

import '../dto/response/module_config_response.dart';

class ModuleConfigApi {
  static const base = String.fromEnvironment('BACKEND_URI');
  final Dio dio;

  const ModuleConfigApi({required this.dio});

  Future<List<ModuleConfigResponse>> getMenuConfigs() async {
    // HttpOnly 쿠키의 botId를 서버가 해석한다. 요청에 방 식별자를 넣지 않는다.
    final response = await dio.get<Map<String, dynamic>>(
      '$base/api/me/module-configs',
      options: Options(extra: {ErrorInterceptor.silentErrorKey: true}),
    );
    final data = response.data;
    final modules = data?['response'];
    if (data?['success'] != true || modules is! List) {
      throw const FormatException('모듈 설정 응답 형식이 올바르지 않습니다.');
    }
    return [
      for (final module in modules)
        ModuleConfigResponse.fromJson(module as Map<String, dynamic>),
    ];
  }
}
