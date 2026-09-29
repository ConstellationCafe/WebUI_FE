import 'package:constellation_cafe/shared/data/dto/response/backend/api_response.dart';

/// `GET /auth/check` 응답.
///
/// `response` 본문: `isLogin`(bool), `roomSelected`(bool), `refreshHint`(bool).
/// 실패하면 `error.status`에 HTTP 상태 코드가 온다.
class AuthCheckResponse {
  final bool success;
  final bool isLogin;
  final bool roomSelected;
  final bool refreshHint;
  final int? errorStatus;

  const AuthCheckResponse({
    required this.success,
    required this.isLogin,
    required this.roomSelected,
    required this.refreshHint,
    this.errorStatus,
  });

  factory AuthCheckResponse.fromApiResponse(ApiResponse response) {
    final body = response.response;
    final json = body is Map<String, dynamic>
        ? body
        : const <String, dynamic>{};
    return AuthCheckResponse(
      success: response.success,
      isLogin: json['isLogin'] == true,
      roomSelected: json['roomSelected'] == true,
      refreshHint: json['refreshHint'] == true,
      errorStatus: response.error?.status,
    );
  }

  bool get isUnauthorized => errorStatus == 401 || errorStatus == 403;
}
