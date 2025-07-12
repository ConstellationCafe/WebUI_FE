import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(
        children: [
          // 홈페이지 메인 컨텐츠
          Text(
            "홈페이지 메인 컨텐츠",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          // 여기에 다른 홈페이지 컨텐츠 추가
        ],
      ),
    );
  }
}