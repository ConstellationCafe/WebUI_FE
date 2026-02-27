import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/ConstSize.dart';
import 'package:constellation_cafe/core/constants/ConstPadding.dart';
import 'package:constellation_cafe/core/di/ApiProvider.dart';

class DiscordLoginButton extends ConsumerWidget {
  const DiscordLoginButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginApi = ref.read(loginApiProvider);

    return SizedBox(
      width: 280,
      height: 30,
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,   // 버튼 배경색
            foregroundColor: Colors.white, // 텍스트/아이콘 색상
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5), // 굴곡 설정
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: ConstPadding.bigPadding,
                vertical: ConstPadding.bigPadding
            ),
          ),
          onPressed: () async {
            await loginApi.discordLogin();
          },
          icon: Icon(Icons.discord), // Flutter에 기본 Discord 아이콘은 없어서 패키지 필요
          label: Text("Discord로 로그인",
            style: TextStyle(
                fontSize: ConstSize.bigTextSize
            ),
          )
      ),
    );
  }
}
