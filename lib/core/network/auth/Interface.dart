import 'package:constellation_cafe/domain/login/method/LoginMethod.dart';
import 'package:constellation_cafe/data/model/response/backend/ApiResponse.dart';

abstract class AuthServiceInterface {
  Future<void> login(LoginMethodType loginMethod);
  Future<void> logout();
  Future<ApiResponse> me();
  Future<ApiResponse> check();
  Future<bool> refresh();
}