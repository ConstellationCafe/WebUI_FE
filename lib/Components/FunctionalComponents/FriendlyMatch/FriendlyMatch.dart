import 'package:constellation_cafe/Components/FunctionalComponents/FriendlyMatch/Post/PostFreindlyMatch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendlyMatch extends ConsumerWidget {
  const FriendlyMatch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(
        children: [
          // TextFormField
          PostFriendlyMatch(),
          // Remained List
        ],
      )
    );
  }
}