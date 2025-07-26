import '../Common/Version/GameVersionType.dart';
import '../Request/JsonBody/JsonBody.dart';

class FriendlyMatchTemplate {
  FriendlyMatchTemplate(
      {required this.version,
      required this.mode,
      required this.platform,
      required this.room_number,
      required this.message});

  final String version;
  final String mode;
  final String platform;
  final String room_number;
  final String message;

  static JsonBody toJson(FriendlyMatchTemplate data) {
    final JsonBody jsonBody = JsonBody(
      dst: "ShadowverseAPI",
      sub: "friendlyMatch",
      targetFunc: "check_match_form",
      args: [
        data.version, // version
        data.mode, // mode
        data.platform, // platform
        data.room_number, // room_number
        data.message // message
      ],
    );

    return jsonBody;
  }
}
