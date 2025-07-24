import 'dart:convert';
import 'dart:io';
import 'dart:async';


class SocketInformation {
  static const String src = 'WebUI';
  // 유효한 소켓 요청인지 서버측에서 확인, 주입 필수
  static final int authId = int.parse(Platform.environment['AUTH_ID']!);
  // 해당 소켓 요청의 처리 우선순위
  static final int pri = int.parse(Platform.environment['PRI'] ?? '1');
  // 소켓 정보
  static final timeout = Duration(seconds: int.parse(Platform.environment['TIMEOUT'] ?? '20'));
  static final int byteSize = int.parse(Platform.environment['BYTE_SIZE'] ?? '4096');
  // 소켓 수신자(Router) 주소 정보
  static final InternetAddress routerAddress = InternetAddress(
      Platform.environment['ROUTER_ADDR'] ?? '192.168.0.14');
  static final int routerPort = int.parse(Platform.environment['ROUTER_PORT']!);
}

class SocketClient extends SocketInformation {
  final String dst;
  final String sub;
  final String targetFunc;
  final List<dynamic> args;

  SocketClient({
    required this.dst,
    required this.sub,
    required this.targetFunc,
    required this.args,
  });

  // 요청 메시지 생성
  Map<String, dynamic> createReqMsg() {
    return {
      "pri": SocketInformation.pri,
      "auth_id": SocketInformation.authId,
      "src": SocketInformation.src,
      "dst": dst,
      "payload": {
        "sub": sub,
        "target_func": targetFunc,
        "args": args,
      }
    };
  }

  // 에러 메세지 생성
  Map<String, dynamic> createErrMsg(String message) {
    return {
      "status_code" : 500,
      "message" : message
    };
  }

  Future<Map<String, dynamic>> send() async {
    final completer = Completer<Map<String, dynamic>>();

    final RawDatagramSocket socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
    final msg = createReqMsg();
    final encodedMsg = utf8.encode(json.encode(msg));

    // UDP 소켓 전송 & 결과 수신
    socket.send(encodedMsg, SocketInformation.routerAddress, SocketInformation.routerPort);
    socket.listen((RawSocketEvent event) {
      if (event == RawSocketEvent.read) {
        final receivedSocket = socket.receive();
        if (receivedSocket != null) {
          Map<String, dynamic> response = {};
          try {
            final String responseStr = utf8.decode(receivedSocket.data);
            response = json.decode(responseStr);
          } catch (e) {
            response = createErrMsg(e.toString());
          } finally {
            socket.close();
            if (!completer.isCompleted) {
              completer.complete(response["payload"]);
            }
          }
        }
      }
    });

    // 타임아웃 처리
    return completer.future.timeout(
      SocketInformation.timeout,
      onTimeout: () {
        socket.close();
        final Map<String, dynamic> response = createErrMsg("타임아웃 발생");
        if (!completer.isCompleted) {
          completer.complete(response["payload"]);
        }
        return response["payload"];
      },
    );
  }

  @override
  String toString() {
    final msg = createReqMsg();
    return msg.toString();
  }
}