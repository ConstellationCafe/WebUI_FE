import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomIcon01 extends ConsumerWidget {
  const CustomIcon01({super.key, this.userImage});

  final String? userImage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 50,
      height: 50,
      child: ClipOval(
        child: userImage != null ? Image.network("temp") : Icon(Icons.person),
      ),
    );
  }
}
