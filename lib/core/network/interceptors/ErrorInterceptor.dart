import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ErrorInterceptor extends Interceptor {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  ErrorInterceptor(this.scaffoldMessengerKey);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String message = _getErrorMessage(err);
    
    // 스낵바 표시
    _showErrorSnackBar(message);
    
    // 원래 에러를 계속 전달
    super.onError(err, handler);
  }

  String _getErrorMessage(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        return '연결 시간이 초과되었습니다';
      case DioExceptionType.sendTimeout:
        return '요청 전송 시간이 초과되었습니다';
      case DioExceptionType.receiveTimeout:
        return '응답 수신 시간이 초과되었습니다';
      case DioExceptionType.badResponse:
        return _getHttpErrorMessage(err.response?.statusCode);
      case DioExceptionType.cancel:
        return '요청이 취소되었습니다';
      case DioExceptionType.connectionError:
        return '네트워크 연결을 확인해주세요';
      default:
        return '알 수 없는 오류가 발생했습니다';
    }
  }

  String _getHttpErrorMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return '잘못된 요청입니다';
      case 401:
        return '로그인이 필요합니다';
      case 403:
        return '접근 권한이 없습니다';
      case 404:
        return '요청한 리소스를 찾을 수 없습니다';
      case 409:
        return '데이터 충돌이 발생했습니다';
      case 422:
        return '입력 데이터를 확인해주세요';
      case 429:
        return '너무 많은 요청이 발생했습니다. 잠시 후 다시 시도해주세요';
      case 500:
        return '서버 내부 오류가 발생했습니다';
      case 502:
        return '서버가 일시적으로 사용할 수 없습니다';
      case 503:
        return '서비스가 일시적으로 중단되었습니다';
      default:
        return '서버 오류가 발생했습니다 (HTTP $statusCode)';
    }
  }

  void _showErrorSnackBar(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        duration: Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.all(16),
      ),
    );
  }
}