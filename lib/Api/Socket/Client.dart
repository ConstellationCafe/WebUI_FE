import 'dart:convert';
import 'dart:async';
import 'package:universal_io/io.dart';
import 'package:constellation_cafe/Api/Socket/Model/SocketModel.dart';

import '../Information/Information.dart';

class SocketClient extends SocketInformation {
  Map<String, dynamic> toJson(SocketModel model) {
    final Map<String, dynamic> map = {
      "pri": SocketInformation.pri,
      "auth_id": SocketInformation.authId,
      "src": SocketInformation.src,
      "dst": model.dst,
      "payload": {
        "sub": model.sub,
        "target_func": model.targetFunc,
        "args": model.args,
      }
    };
    print(map);
    return map;
  }

  // 에러 메세지 생성
  Map<String, dynamic> createErrMsg(String message) {
    return {"status_code": 500, "message": message};
  }

  Future<Map<String, dynamic>?> send(SocketModel model) async {
    final msg = toJson(model);
    final encodedMsg = utf8.encode(json.encode(msg));
    Map<String, dynamic>? response;

    print("check");
    final serverAddress = (await InternetAddress.lookup(SocketInformation.routerAddress)).first;
    print(serverAddress);
    print("check");
    final socket = await RawDatagramSocket.bind(
        serverAddress.type == InternetAddressType.IPv4
            ? InternetAddress.anyIPv4
            : InternetAddress.anyIPv6,
        0);
    print("check");
    socket.broadcastEnabled = true;
    socket.send(encodedMsg, serverAddress, SocketInformation.routerPort);
    socket.listen((RawSocketEvent event) {
      if (event == RawSocketEvent.read) {
        final datagram = socket.receive();
        if (datagram != null) {
          final data = utf8.decode(datagram.data);
          response = json.decode(data);
        }
      }
    });
  }
}
