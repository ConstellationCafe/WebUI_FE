class SocketModel {
  SocketModel({
    required this.dst,
    required this.sub,
    required this.targetFunc,
    required this.args,
  });

  final String dst;
  final String sub;
  final String targetFunc;
  final List<String> args;

  // JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'dst': dst,
      'sub': sub,
      'targetFunc': targetFunc,
      'args': args,
    };
  }

  // JSON에서 객체 생성
  factory SocketModel.fromJson(Map<String, dynamic> json) {
    return SocketModel(
      dst: json['dst'].toString(),
      sub: json['sub'].toString(),
      targetFunc: json['targetFunc'].toString(),
      args: List<String>.from(json['args']),
    );
  }
}