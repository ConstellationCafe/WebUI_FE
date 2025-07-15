import '../Common/Version/GameVersionType.dart';
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

  Map<String, dynamic> toJson(FriendlyMatchTemplate template) {
    return {
      "version": version.name,
      "mode": mode.name,
      "bo": bo.name,
      "room": room,
      "message": message,
    };
  }
}
