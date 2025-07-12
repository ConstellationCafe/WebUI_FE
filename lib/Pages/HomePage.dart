import 'package:constellation_cafe/Components/AppBar/AppBar.dart';
import 'package:constellation_cafe/Components/Category/Category.dart';
import 'package:constellation_cafe/Constant/ConstPadding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Components/CustomIcon/CustomIcon01.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: 1000,
        padding:
            EdgeInsetsGeometry.fromLTRB(ConstPadding.bigPadding, ConstPadding.bigPadding, ConstPadding.bigPadding, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [MainAppBar(), CustomIcon01()],
            ),
            MainCategory(),
          ],
        ),
      ),
    );
  }
}
