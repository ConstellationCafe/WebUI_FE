import 'ModeType.dart';

enum FriendlyMatchS2ModeType implements FriendlyMatchModeType {
  rotation("로테이션"),
  unlimited("언리미티드");

  final String _name;

  const FriendlyMatchS2ModeType(this._name);

  FriendlyMatchS2ModeType stringToType(String value) {
    switch (value) {
      case "rotation":
        return FriendlyMatchS2ModeType.rotation;
      case "unlimited":
        return FriendlyMatchS2ModeType.unlimited;
      default:
        return FriendlyMatchS2ModeType.rotation;
    }
  }

  @override
  String get name => _name;
}
