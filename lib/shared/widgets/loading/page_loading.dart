import 'package:flutter/material.dart';

/// 화면 전체를 채우는 로딩 표시.
class PageLoading extends StatelessWidget {
  const PageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
