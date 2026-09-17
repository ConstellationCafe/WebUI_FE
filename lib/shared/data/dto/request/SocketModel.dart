/// Request json body type
class SocketModel {
  static String src = "WebUI";
  final String dst;
  final String sub;
  final String targetFunc;
  final List<dynamic> args;

  SocketModel({
    required this.dst,
    required this.sub,
    required this.targetFunc,
    required this.args,
  });

  // JSON으로 변환 (전송만 하기에 fromJson이 필요하지 않음)
  Map<String, dynamic> toJson() {
    return {
      "pri": 1,
      "auth_id": 731001,
      "src": src,
      "dst": dst,
      "payload": {
        "sub": sub,
        "target_func": targetFunc,
        "args": args
      }
    };
  }
}
