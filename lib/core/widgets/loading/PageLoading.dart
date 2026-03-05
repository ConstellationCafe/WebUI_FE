import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageLoading extends ConsumerWidget {
  const PageLoading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SizedBox.expand(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}