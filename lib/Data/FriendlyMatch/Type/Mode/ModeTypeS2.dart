import 'ModeType.dart';

enum FriendlyMatchS2ModeType implements FriendlyMatchModeType {
  rotation("로테이션"),
  unlimited("언리미티드");

  @override
  final String name;

  const FriendlyMatchS2ModeType(this.name);

  FriendlyMatchS2ModeType stringToType(String value) {
    switch (value) {
      case "로테이션":
        return FriendlyMatchS2ModeType.rotation;
      case "언리미티드":
        return FriendlyMatchS2ModeType.unlimited;
      default:
        return FriendlyMatchS2ModeType.rotation;
    }
  }

  static String typeToString(FriendlyMatchS2ModeType value) {
    switch (value) {
      case FriendlyMatchS2ModeType.rotation:
        return "로테이션";
      case FriendlyMatchS2ModeType.unlimited:
        return "언리미티드";
    }
  }
}
