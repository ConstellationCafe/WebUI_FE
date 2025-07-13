import 'ModeType.dart';

enum FriendlyMatchS1ModeType implements FriendlyMatchModeType {
  rotation("로테이션"),
  unlimited("언리미티드"),
  two_pick("투픽"),
  timeslip_rotation("타임슬립 로테이션");

  final String _name;

  const FriendlyMatchS1ModeType(this._name);

  FriendlyMatchS1ModeType stringToType(String value) {
    switch (value) {
      case "rotation":
        return FriendlyMatchS1ModeType.rotation;
      case "unlimited":
        return FriendlyMatchS1ModeType.unlimited;
      case "two_pick":
        return FriendlyMatchS1ModeType.two_pick;
      case "timeslip_rotation":
        return FriendlyMatchS1ModeType.timeslip_rotation;
      default:
        return FriendlyMatchS1ModeType.rotation;
    }
  }

  @override
  String get name => _name;
}
