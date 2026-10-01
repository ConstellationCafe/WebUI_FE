import 'package:constellation_cafe/feature/modules/shadowverse/friendly_match/domain/friendly_match_template.dart';
import 'package:constellation_cafe/shared/data/dto/request/socket_model.dart';

/// 빗자루 봇 `ShadowverseAPI.friendlyMatch.check_match_form` 요청.
///
/// `args`: `["True", [version, mode, platform, room_number, message], room_name, sender]`
/// 첫 값은 Discord가 아닌 WebUI에서 보냈다는 표시(from_discord)다.
class FriendlyMatchRequest {
  static const destination = 'ShadowverseAPI';
  static const module = 'friendlyMatch';
  static const function = 'check_match_form';

  /// 모집 글을 올리는 채팅방 이름. 봇 router 계약값이다.
  static const roomName = '섀버 별자리 Cafe';
  static const fromDiscord = 'True';

  final FriendlyMatchTemplate template;

  const FriendlyMatchRequest(this.template);

  String get path => '/$destination/$module/$function';

  List<dynamic> get args => [
    fromDiscord,
    [
      template.version,
      template.mode,
      template.platform,
      template.roomNumber,
      template.message,
    ],
    roomName,
    template.sender,
  ];

  SocketModel toSocketModel() => SocketModel(
    dst: destination,
    sub: module,
    targetFunc: function,
    args: args,
  );
}
