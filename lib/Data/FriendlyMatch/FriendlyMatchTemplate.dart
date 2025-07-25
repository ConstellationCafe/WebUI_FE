import '../Common/Version/GameVersionType.dart';
import '../Request/JsonBody/JsonBody.dart';
import 'Bo/Type/BoType.dart';
import 'Mode/Type/ModeType.dart';

class FriendlyMatchTemplate {
  FriendlyMatchTemplate(
      {required this.version, required this.mode, required this.bo, required this.room, required this.message});

  final GameVersionType version;
  final FriendlyMatchModeType mode;
  final FriendlyMatchBoType bo;
  final String room;
  final String message;

  static JsonBody toJson(FriendlyMatchTemplate data) {
    final JsonBody jsonBody = JsonBody(
      dst: "DiscordBot",
      sub: "test_match",
      targetFunc: "check_match_form",
      args: [
        GameVersionType.typeToString(data.version),
        data.mode.toString(),
        data.bo.toString(),
        data.room,
        data.message
      ],
    );

    return jsonBody;
  }
}
