import 'ModeType.dart';

enum FriendlyMatchS1ModeType implements FriendlyMatchModeType{
  rotation("로테이션"),
  unlimited("언리미티드"),
  two_pick("투픽"),
  timeslip_rotation("타임슬립 로테이션");

  final String _name;

  const FriendlyMatchS1ModeType(this._name);



  @override
  String get name => _name;
}
