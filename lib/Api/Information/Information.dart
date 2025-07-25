class SocketInformation {
  static const String src = 'WebUI';

  static final int authId = 731001;

  // 해당 소켓 요청의 처리 우선순위
  static final int pri = 1;

  // 소켓 정보
  static final timeout = 20;
  static final int byteSize = 4096;

  // 소켓 수신자(Router) 주소 정보
  static final String routerAddress = 'msiwol.iptime.org';
  static final int routerPort = 1103;
}
