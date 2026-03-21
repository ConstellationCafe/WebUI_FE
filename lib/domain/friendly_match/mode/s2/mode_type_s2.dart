import '../Type/mode_type.dart';

enum FriendlyMatchS2ModeType implements FriendlyMatchModeType {
  rotation("로테이션");

  @override
  final String name;

  const FriendlyMatchS2ModeType(this.name);

  FriendlyMatchS2ModeType stringToType(String value) {
    switch (value) {
      case "로테이션":
        return FriendlyMatchS2ModeType.rotation;
      default:
        return FriendlyMatchS2ModeType.rotation;
    }
  }

  @override
  String typeToString() {
    switch (this) {
      case FriendlyMatchS2ModeType.rotation:
        return "로테이션";
    }
  }
}
