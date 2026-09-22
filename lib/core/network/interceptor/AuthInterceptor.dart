import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  static const _retryKey = 'authRetry';

  final Dio dio;
  Future<void>? _refreshing;

  AuthInterceptor(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final requestOptions = err.requestOptions;
    final statusCode = err.response?.statusCode;

    if (requestOptions.path.contains('/auth/refresh') ||
        requestOptions.extra[_retryKey] == true ||
        (statusCode != 401 && statusCode != 403)) {
      return handler.next(err);
    }

    try {
      _refreshing ??= _doRefresh();
      await _refreshing;

      final retryOptions = Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
        responseType: requestOptions.responseType,
        contentType: requestOptions.contentType,
        extra: {...requestOptions.extra, _retryKey: true},
        validateStatus: requestOptions.validateStatus,
        receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
      );

      final response = await dio.request<dynamic>(
        requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: retryOptions,
        cancelToken: requestOptions.cancelToken,
        onReceiveProgress: requestOptions.onReceiveProgress,
        onSendProgress: requestOptions.onSendProgress,
      );
      return handler.resolve(response);
    } catch (_) {
      return handler.next(err);
    } finally {
      _refreshing = null;
    }
  }

  Future<void> _doRefresh() async {
    final response = await dio.post<dynamic>('/auth/refresh');
    if (response.statusCode != 200) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
  }
}
