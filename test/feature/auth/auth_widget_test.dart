import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/core/constants/theme_data.dart';
import 'package:constellation_cafe/feature/auth/constants/auth_constants.dart';
import 'package:constellation_cafe/feature/auth/domain/method/login_method.dart';
import 'package:constellation_cafe/feature/auth/pages/login.dart';
import 'package:constellation_cafe/feature/auth/service/login.dart';
import 'package:constellation_cafe/feature/auth/widgets/discord_login_button.dart';

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

Future<void> setSurface(WidgetTester tester, Size size) async {
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));
}

void main() {
  testWidgets('로그인 화면은 서비스 이름과 Discord 로그인 버튼을 보여준다', (tester) async {
    await setSurface(tester, const Size(1400, 900));
    await tester.pumpWidget(loginApp(FakeAuthService()));
    await tester.pumpAndSettle();

    expect(find.text('ERP Web Service'), findsOneWidget);
    expect(find.text('Discord로 로그인'), findsOneWidget);
    expect(find.byIcon(Icons.discord), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Discord 로그인 버튼을 누르면 Discord 로그인을 요청한다', (tester) async {
    final auth = FakeAuthService();
    await setSurface(tester, const Size(1400, 900));
    await tester.pumpWidget(loginApp(auth));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Discord로 로그인'));
    await tester.pump();

    expect(auth.logins, [LoginMethodType.discord]);
  });

  testWidgets('데스크톱에서는 버튼 너비를 고정하고 모바일에서는 카드 너비를 채운다', (tester) async {
    final button = find.descendant(
      of: find.byType(DiscordLoginButton),
      matching: find.byType(SizedBox),
    );

    await setSurface(tester, const Size(1400, 900));
    await tester.pumpWidget(loginApp(FakeAuthService()));
    await tester.pumpAndSettle();
    expect(
      tester.getSize(button.first).width,
      AuthConstants.discordLoginButtonDesktopWidth,
    );

    await setSurface(tester, const Size(390, 800));
    await tester.pumpAndSettle();
    expect(
      tester.getSize(button.first).width,
      greaterThan(AuthConstants.discordLoginButtonDesktopWidth),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('큰 글자 설정에서도 로그인 카드가 넘치지 않는다', (tester) async {
    await setSurface(tester, const Size(390, 800));
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
