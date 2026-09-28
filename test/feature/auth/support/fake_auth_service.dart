import 'package:constellation_cafe/feature/auth/api/auth_Interface.dart';
import 'package:constellation_cafe/feature/auth/domain/method/login_method.dart';
import 'package:constellation_cafe/shared/data/dto/response/backend/ApiResponse.dart';

Map<String, dynamic> meJson() => {
  'discordId': '123',
  'globalName': '별',
  'roles': ['ROLE_ADMIN'],
  'avatar': 'https://cdn.example.invalid/a.png',
};

ApiResponse checkResponse({
  bool isLogin = false,
  bool roomSelected = false,
  bool refreshHint = false,
}) {
  final body = {
    'isLogin': isLogin,
    'roomSelected': roomSelected,
    'refreshHint': refreshHint,
  };
  return ApiResponse(success: true, response: body, error: null);
}

ApiResponse errorResponse(int status) {
  final error = ApiError(status: status, message: 'denied');
  return ApiResponse(success: false, response: null, error: error);
}

class FakeAuthService implements AuthServiceInterface {
  final List<ApiResponse> checks = [];
  bool refreshResult = false;
  int checkCalls = 0;
  int refreshCalls = 0;
  int meCalls = 0;
  int logoutCalls = 0;
  final List<LoginMethodType> logins = [];

  @override
  Future<ApiResponse> check() async {
    checkCalls++;
    return checks.removeAt(0);
  }

  @override
  Future<bool> refresh() async {
    refreshCalls++;
    return refreshResult;
  }

  @override
  Future<ApiResponse> me() async {
    meCalls++;
    return ApiResponse(success: true, response: meJson(), error: null);
  }

  @override
  Future<void> login(LoginMethodType loginMethod) async {
    logins.add(loginMethod);
  }

  @override
  Future<void> logout() async {
    logoutCalls++;
  }
}
