import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserForm extends ConsumerWidget {
  const UserForm({super.key});

  @override
  Widget build(BuildContext build, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(build).colorScheme.tertiary),
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            "회원증",
            style: TextStyle(fontSize: 14, color: Colors.white),
          )
        ],
      ),
    );
  }
}
