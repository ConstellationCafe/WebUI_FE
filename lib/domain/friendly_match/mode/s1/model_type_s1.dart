import '../Type/model_type.dart';

enum FriendlyMatchS1ModeType implements FriendlyMatchModeType {
  timeslip_rotation("타임슬립 로테이션"),
  unlimited("언리미티드"),
  two_pick("투픽");


  @override
  final String name;

  const FriendlyMatchS1ModeType(this.name);


  static FriendlyMatchS1ModeType stringToType(String value) {
    switch (value) {
      case "타임슬립 로테이션":
        return FriendlyMatchS1ModeType.timeslip_rotation;
      case "언리미티드":
        return FriendlyMatchS1ModeType.unlimited;
      case "투픽":
        return FriendlyMatchS1ModeType.two_pick;
      default:
        return FriendlyMatchS1ModeType.timeslip_rotation;
    }
  }

  @override
  String typeToString() {
    switch (this) {
      case FriendlyMatchS1ModeType.timeslip_rotation:
        return "타임슬립 로테이션";
      case FriendlyMatchS1ModeType.unlimited:
        return "언리미티드";
      case FriendlyMatchS1ModeType.two_pick:
        return "투픽";
    }
  }
}
