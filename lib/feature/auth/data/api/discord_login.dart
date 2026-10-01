import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'browser/browser_redirect.dart';

class DiscordLogin {
  /// Discord OAuth application client ID. 값은 --dart-define으로 주입한다(docs/deploy.md).
  static const clientId = String.fromEnvironment('CLIENT_ID');

  /// Discord OAuth redirect URI. 값은 --dart-define으로 주입한다(docs/deploy.md).
  static const redirectUri = String.fromEnvironment('REDIRECT_URI');

  static const scope = "identify+guilds";

  Uri get discordAuthUri => Uri.https("discord.com", "/oauth2/authorize", {
    "client_id": clientId,
    "redirect_uri": redirectUri,
    "response_type": "code",
    "scope": scope,
  });

  void login() {
    final uri = discordAuthUri;

    if (kIsWeb) {
      // Flutter Web: 현재 페이지를 Discord 로그인 페이지로 교체
      redirectCurrentPage(uri);
    } else {
      // Mobile: 외부 브라우저 열기
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
