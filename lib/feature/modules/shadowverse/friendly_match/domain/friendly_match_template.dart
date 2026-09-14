

import 'package:constellation_cafe/shared/model/request/SocketModel.dart';

class FriendlyMatchTemplate {
  FriendlyMatchTemplate(
      {required this.version,
      required this.mode,
      required this.platform,
      required this.roomNumber,
      required this.message,
      required this.sender});

  final String version;
  final String mode;
  final String platform;
  final String roomNumber;
  final String message;
  final String sender;

  static SocketModel toJson(FriendlyMatchTemplate data) {
    final SocketModel jsonBody = SocketModel(
      dst: "ShadowverseAPI",
      sub: "friendlyMatch",
      targetFunc: "check_match_form",
      args: [
        "True",
        [
          data.version, // version
          data.mode, // mode
          data.platform, // platform
          data.roomNumber, // room_number
          data.message // message
        ],
        "섀버 별자리 Cafe",
        data.sender
      ],
    );
    return jsonBody;
  }
}
