import 'dart:html' as web;
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class DiscordLogin {
  static const clientId = String.fromEnvironment('CLIENT_ID');  // 977062370327298079

  static const redirectUri = String.fromEnvironment('REDIRECT_URI');  // https://constellationcafe.p-e.kr/auth/discord_login

  static const scope = "identify";

  Uri get discordAuthUri => Uri.https(
    "discord.com",
    "/api/oauth2/authorize",
    {
      "client_id": clientId,
      "redirect_uri": redirectUri,
      "response_type": "code",
      "scope": scope,
    },
  );

  void login() {
    final uri = discordAuthUri;

    if (kIsWeb) {
      // Flutter Web: 현재 페이지를 Discord 로그인 페이지로 교체
      web.window.location.href = uri.toString();
    } else {
      // Mobile: 외부 브라우저 열기
      launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
