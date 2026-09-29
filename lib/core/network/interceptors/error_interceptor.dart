import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:constellation_cafe/shared/widgets/snack_bar/error_snack_bar.dart';

import '../network_strings.dart';

class ErrorInterceptor extends Interceptor {
  /// 요청 `extra`에 true로 넣으면 전역 오류 SnackBar를 띄우지 않는다.
  /// 화면이 직접 오류 상태를 보여주거나, 백그라운드 재조회처럼 사용자가
  /// 요청하지 않은 호출에 사용한다.
  static const silentErrorKey = 'silentError';

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  ErrorInterceptor(this.scaffoldMessengerKey);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final path = err.requestOptions.path;
    final isSilentAuthError =
        (err.response?.statusCode == 401 || err.response?.statusCode == 403) &&
        path.contains('/auth/');
    final isSilentRequest = err.requestOptions.extra[silentErrorKey] == true;

    if (!isSilentAuthError && !isSilentRequest) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        ErrorSnackBar(message: _getErrorMessage(err)),
      );
    }

    super.onError(err, handler);
  }

  String _getErrorMessage(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkStrings.connectionTimeout;
      case DioExceptionType.sendTimeout:
        return NetworkStrings.sendTimeout;
      case DioExceptionType.receiveTimeout:
        return NetworkStrings.receiveTimeout;
      case DioExceptionType.badResponse:
        return _getHttpErrorMessage(err.response?.statusCode);
      case DioExceptionType.cancel:
        return NetworkStrings.canceled;
      case DioExceptionType.connectionError:
        return NetworkStrings.connectionError;
      default:
        return NetworkStrings.unknown;
    }
  }

  String _getHttpErrorMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return NetworkStrings.badRequest;
      case 404:
        return NetworkStrings.notFound;
      case 409:
        return NetworkStrings.conflict;
      case 422:
        return NetworkStrings.unprocessable;
      case 429:
        return NetworkStrings.tooManyRequests;
      case 500:
        return NetworkStrings.internalServerError;
      case 502:
        return NetworkStrings.badGateway;
      case 503:
        return NetworkStrings.serviceUnavailable;
      default:
        return NetworkStrings.serverError;
    }
  }
}
