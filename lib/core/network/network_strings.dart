/// 네트워크 오류를 사용자에게 알릴 때 쓰는 문구.
abstract final class NetworkStrings {
  static const connectionTimeout = '연결 시간이 초과되었습니다';
  static const sendTimeout = '요청 전송 시간이 초과되었습니다';
  static const receiveTimeout = '응답 수신 시간이 초과되었습니다';
  static const canceled = '요청이 취소되었습니다';
  static const connectionError = '네트워크 연결을 확인해주세요';
  static const unknown = '알 수 없는 오류가 발생했습니다';
  static const badRequest = '잘못된 요청입니다';
  static const notFound = '요청한 리소스를 찾을 수 없습니다';
  static const conflict = '데이터 충돌이 발생했습니다';
  static const unprocessable = '입력 데이터를 확인해주세요';
  static const tooManyRequests = '너무 많은 요청이 발생했습니다. 잠시 후 다시 시도해주세요';
  static const internalServerError = '서버 내부 오류가 발생했습니다';
  static const badGateway = '서버가 일시적으로 사용할 수 없습니다';
  static const serviceUnavailable = '서비스가 일시적으로 중단되었습니다';
  static const serverError = '서버 오류가 발생했습니다';

  // 빗자루 봇 router 호출
  static const botRouterTimeout = '요청 시간이 초과되었습니다.';
  static const botRouterServerError = '서버 오류가 발생했습니다.';
  static const botRouterNetworkError = '네트워크 연결 오류가 발생했습니다.';
  static const botRouterFormatError = '응답 데이터 형식 오류가 발생했습니다.';
  static const botRouterUnknownError = '알 수 없는 오류가 발생했습니다.';

  static String botRouterStatusError(int statusCode) =>
      '서버 오류가 발생했습니다. ($statusCode)';
}
