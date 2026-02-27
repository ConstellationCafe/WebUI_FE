

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonLoading extends ConsumerWidget {
  const ButtonLoading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CircularProgressIndicator(
      strokeWidth: 2,
      color: Colors.white,
    );
  }
}