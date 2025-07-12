import 'package:constellation_cafe/Components/AppBar/AppBar.dart';
import 'package:constellation_cafe/Components/Category/Category.dart';
import 'package:constellation_cafe/Constant/ConstPadding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: 500,
        padding: ConstPadding.bigPaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainAppBar(),
            MainCategory(),
          ],
        ),
      ),
    );
  }
}
