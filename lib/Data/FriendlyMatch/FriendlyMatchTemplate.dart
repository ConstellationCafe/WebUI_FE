import 'package:constellation_cafe/Data/FriendlyMatch/Type/Bo/BoType.dart';
import 'package:constellation_cafe/Data/FriendlyMatch/Type/Version/VersionType.dart';

import 'Type/Mode/ModeType.dart';

class FriendlyMatchTemplate {
  FriendlyMatchTemplate(
      {required this.version, required this.mode, required this.bo, required this.room, required this.message});

  final FriendlyMatchVersionType version;
  final FriendlyMatchModeType mode;
  final FriendlyMatchBoType bo;
  final String room;
  final String message;

  Map<String, dynamic> toJson (FriendlyMatchTemplate template) {
    return {
      "version": version.toString(),
      "mode": mode.
    };
  }
}
