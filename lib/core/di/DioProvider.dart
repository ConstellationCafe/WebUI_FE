import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/interceptor/AuthInterceptor.dart';
import '../network/interceptors/ErrorInterceptor.dart';
import '../keys/AppKeys.dart';

// Network
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  // AuthInterceptor 먼저 추가
  dio.interceptors.add(AuthInterceptor(dio));
  // ErrorInterceptor 나중에 추가 (모든 에러를 캐치하기 위해)
  dio.interceptors.add(ErrorInterceptor(AppKeys.scaffoldMessengerKey));
  return dio;
});