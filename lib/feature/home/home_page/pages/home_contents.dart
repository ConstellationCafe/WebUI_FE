import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/feature/auth/notifier/login_check_notifier.dart';

import '../../../../core/constants/const_size.dart';

class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      "홈페이지 메인 컨텐츠",
      style: TextStyle(fontSize: ConstSize.largeTextSize),
    );
  }
}