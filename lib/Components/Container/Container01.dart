import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Container01 extends ConsumerWidget {
  Container01({required this.icon, required this.text});

  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 150,
      height: 90,
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black38), borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [icon, Text(text)],
        ),
      ),
    );
  }
}
