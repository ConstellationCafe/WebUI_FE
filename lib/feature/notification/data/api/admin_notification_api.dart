import 'package:dio/dio.dart';

import 'package:constellation_cafe/core/network/interceptors/error_interceptor.dart';

import '../dto/request/admin_notification_history_request.dart';
import '../dto/request/admin_notification_publish_request.dart';
import '../dto/response/admin_notification_page_response.dart';
import '../dto/response/notification_publish_response.dart';

/// 관리자 알림 API(`/api/admin/notifications`, ADR-0002 경로 규칙).
class AdminNotificationApi {
  static const base = String.fromEnvironment('BACKEND_URI');
  static const path = '$base/api/admin/notifications';

  final Dio dio;

  const AdminNotificationApi({required this.dio});

  Future<NotificationPublishResponse> publish(
    AdminNotificationPublishRequest request,
  ) async {
    final response = await dio.post<Map<String, dynamic>>(
      path,
      data: request.toJson(),
      options: _silent(),
    );
    return NotificationPublishResponse.fromJson(_responseBody(response.data));
  }

  Future<AdminNotificationPageResponse> getHistory(
    AdminNotificationHistoryRequest request,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      path,
      queryParameters: request.toJson(),
      options: _silent(),
    );
    return AdminNotificationPageResponse.fromJson(_responseBody(response.data));
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
