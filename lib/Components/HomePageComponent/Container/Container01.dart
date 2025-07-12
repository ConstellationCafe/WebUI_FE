import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Container01 extends ConsumerWidget {
  Container01({required this.iconImage, required this.text});

  final Image iconImage;
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 150,
      height: 90,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 45,
              height: 45,
              child: ClipOval(
                child: iconImage,
              ),
            ),
            Text(text)
          ],
        ),
      ),
    );
  }
}
