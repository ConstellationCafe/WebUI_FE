import 'package:dio/dio.dart';

import 'package:constellation_cafe/core/network/interceptors/error_interceptor.dart';

import '../dto/request/notification_list_request.dart';
import '../dto/request/notification_read_cursor_request.dart';
import '../dto/response/notification_slice_response.dart';
import '../dto/response/notification_unread_response.dart';

/// 로그인한 회원 본인의 알림 API(`/api/me/notifications`).
class NotificationApi {
  static const base = String.fromEnvironment('BACKEND_URI');
  static const path = '$base/api/me/notifications';
  static const streamPath = '$path/stream';

  final Dio dio;

  const NotificationApi({required this.dio});

  Future<NotificationSliceResponse> getNotifications(
    NotificationListRequest request,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      path,
      queryParameters: request.toJson(),
      options: _silent(),
    );
    return NotificationSliceResponse.fromJson(_responseBody(response.data));
  }

  Future<NotificationUnreadResponse> getUnreadCount() async {
    final response = await dio.get<Map<String, dynamic>>(
      '$path/unread-count',
      options: _silent(),
    );
    return NotificationUnreadResponse.fromJson(_responseBody(response.data));
  }

  Future<NotificationUnreadResponse> markRead(
    NotificationReadCursorRequest request,
  ) async {
    final response = await dio.put<Map<String, dynamic>>(
      '$path/read-cursor',
      data: request.toJson(),
      options: _silent(),
    );
    return NotificationUnreadResponse.fromJson(_responseBody(response.data));
  }

  /// 화면이 오류 상태를 직접 보여주므로 전역 오류 SnackBar를 띄우지 않는다.
  Options _silent() => Options(extra: {ErrorInterceptor.silentErrorKey: true});

  Map<String, dynamic> _responseBody(Map<String, dynamic>? data) {
    final response = data?['response'];
    if (data?['success'] != true || response is! Map<String, dynamic>) {
      throw const FormatException('알림 API 응답 형식이 올바르지 않습니다.');
    }
    return response;
  }
}
