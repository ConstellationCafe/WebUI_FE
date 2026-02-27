import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class AuthInterceptor extends Interceptor {
  final Dio dio;

  Future<void>? _refreshing;

  AuthInterceptor(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    final requestOptions = err.requestOptions;

    // refresh 요청 자체는 가로채면 안 됨
    if (requestOptions.path.contains('/auth/refresh')) {
      return handler.next(err);
    }
    if (statusCode == 403) {
      try {
        // 이미 refresh 중이면 기다림
        _refreshing ??= _doRefresh();
        await _refreshing;
        _refreshing = null;

        // refresh 성공 후 재시도
        final retryResponse = await _retry(requestOptions);
        return handler.resolve(retryResponse);
      } catch (e) {
        _refreshing = null;
        return handler.next(err); // refresh 실패 → 그대로 에러
      }
    }
    handler.next(err);
  }

  Future<void> _doRefresh() async {
    final res = await http.post(
        Uri.parse('/auth/refresh'),
        headers: {"Accept": "application/json"}
    );
    if (res.statusCode != 200) {
      throw Exception('refresh 실패');
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) {
    // RequestOptions는 그대로 재사용하면 위험
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
      responseType: requestOptions.responseType,
      contentType: requestOptions.contentType,
      extra: requestOptions.extra,
    );
    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
