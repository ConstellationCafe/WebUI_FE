import 'package:constellation_cafe/feature/auth/domain/method/login_method.dart';
import 'package:constellation_cafe/shared/model/response/backend/ApiResponse.dart';

abstract class AuthServiceInterface {
  Future<void> login(LoginMethodType loginMethod);
  Future<void> logout();
  Future<ApiResponse> me();
  Future<ApiResponse> check();
  Future<bool> refresh();
}