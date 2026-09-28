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

    // 백엔드에서 403은 항상 순수 비즈니스 규칙 거부다(예:
    // GUILD_NOT_REGISTERED, GUILD_MEMBER_NOT_FOUND). 토큰/세션 문제는
    // GlobalExceptionHandler.handleAuthorizationDeniedException이
    // 미인증이면 401로, 인증됐지만 권한 없음이면 404로 내려준다 — 403이
    // 아니다. 즉 refresh로 해결될 수 있는 경우는 401뿐이라, 403에
    // refresh-and-retry를 시도하는 건 항상 헛수고이고(같은 방을 다시
    // 선택 못 하는 이유는 refresh로 바뀌지 않는다) 에러 노출도 늦춘다.
    if (requestOptions.path.contains('/auth/refresh') ||
        requestOptions.extra[_retryKey] == true ||
        statusCode != 401) {
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
