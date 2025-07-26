class SocketModel {
  SocketModel(
      {required this.subject,
      required this.from_discord,
      required this.dst,
      required this.sub,
      required this.targetFunc,
      required this.args,
      required this.room_name,
      required this.sender});

  final String subject;
  final bool from_discord;
  final String dst;
  final String sub;
  final String targetFunc;
  final List<String> args;
  final String room_name;
  final String sender;

  // JSON으로 변환 (전송만 하기에 fromJson이 필요하지 않음)
  Map<String, dynamic> toJson() {
    return {
      "header": {
        "location": "WebUI",
        "date_time": DateTime.now().toIso8601String(),
        "api_path": "$dst/$sub/$targetFunc",
        "subject": subject,
      },
      "body": {'from_discord': from_discord, 'args': args, 'room_name': room_name, 'sender': sender}
    };
  }
}
