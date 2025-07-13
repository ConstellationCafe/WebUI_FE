import 'ModeType.dart';

enum FriendlyMatchS2ModeType implements FriendlyMatchModeType {
  rotation("로테이션"),
  unlimited("언리미티드");

  final String _name;

  const FriendlyMatchS2ModeType(this._name);

  @override
  String get name => _name;
}
