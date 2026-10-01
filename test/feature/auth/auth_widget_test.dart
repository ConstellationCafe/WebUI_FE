import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/core/constants/theme_data.dart';
import 'package:constellation_cafe/feature/auth/constants/auth_constants.dart';
import 'package:constellation_cafe/feature/auth/data/repository/login.dart';
import 'package:constellation_cafe/feature/auth/domain/method/login_method.dart';
import 'package:constellation_cafe/feature/auth/pages/login.dart';
import 'package:constellation_cafe/feature/auth/widgets/discord_login_button.dart';

import '../../support/screen.dart';
import 'support/fake_auth_service.dart';

Widget loginApp(FakeAuthService auth) => ProviderScope(
  overrides: [loginApiProvider.overrideWithValue(Login(auth))],
  child: MaterialApp(theme: CustomTheme.themeData, home: const LoginPage()),
);

Widget doubleText(BuildContext context, Widget? child) {
  final data = MediaQuery.of(context);
  final scaled = data.copyWith(textScaler: const TextScaler.linear(2));
  return MediaQuery(data: scaled, child: child!);
}

void main() {
  testWidgets('로그인 화면은 서비스 이름과 Discord 로그인 버튼을 보여준다', (tester) async {
    setScreenSize(tester, const Size(1400, 900));
    await tester.pumpWidget(loginApp(FakeAuthService()));
    await tester.pumpAndSettle();

    expect(find.text('ERP Web Service'), findsOneWidget);
    expect(find.text('Discord로 로그인'), findsOneWidget);
    expect(find.byIcon(Icons.discord), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Discord 로그인 버튼을 누르면 Discord 로그인을 요청한다', (tester) async {
    final auth = FakeAuthService();
    setScreenSize(tester, const Size(1400, 900));
    await tester.pumpWidget(loginApp(auth));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Discord로 로그인'));
    await tester.pump();

    expect(auth.logins, [LoginMethodType.discord]);
  });

  testWidgets('화면 폭에 따라 로그인 버튼 너비 설정을 바꾼다', (tester) async {
    final button = find.descendant(
      of: find.byType(DiscordLoginButton),
      matching: find.byType(SizedBox),
    );
    double? configuredWidth() => tester.widget<SizedBox>(button.first).width;

    setScreenSize(tester, const Size(1400, 900));
    await tester.pumpWidget(loginApp(FakeAuthService()));
    await tester.pumpAndSettle();
    expect(configuredWidth(), AuthConstants.discordLoginButtonDesktopWidth);

    setScreenSize(tester, const Size(390, 800));
    await tester.pumpAndSettle();
    expect(configuredWidth(), double.infinity);
    expect(tester.takeException(), isNull);
  });

  testWidgets('큰 글자 설정에서도 로그인 카드가 넘치지 않는다', (tester) async {
    setScreenSize(tester, const Size(390, 800));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          loginApiProvider.overrideWithValue(Login(FakeAuthService())),
        ],
        child: MaterialApp(
          theme: CustomTheme.themeData,
          builder: doubleText,
          home: const LoginPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Discord로 로그인'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
