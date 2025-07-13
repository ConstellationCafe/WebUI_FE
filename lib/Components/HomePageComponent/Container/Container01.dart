import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Container01 extends ConsumerWidget {
  Container01({required this.iconImage, required this.text});

  final Image iconImage;
  final String text;

  @override
  Widget build(BuildContext build, WidgetRef ref) {
    return Container(
      width: 150,
      height: 90,
      child: Center(
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
              color: Theme.of(build).colorScheme.onSecondary),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 8),
                SizedBox(
                  width: 35,
                  height: 35,
                  child: iconImage,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 14, color: Theme.of(build).colorScheme.tertiary),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
