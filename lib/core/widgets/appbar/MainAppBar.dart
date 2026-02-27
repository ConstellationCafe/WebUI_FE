import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainAppBar extends ConsumerStatefulWidget {
  const MainAppBar({super.key});

  @override
  ConsumerState<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends ConsumerState<MainAppBar> {
  @override
  Widget build(BuildContext build) {
    return SizedBox(
      width: 155,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              build.go('/');
            },
            child: ClipOval(
              child: Image.asset(
                "assets/icons/main_icon.jpg",
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          Spacer(),
          Text("섀버 별자리 Cafe")
        ],
      ),
    );
  }
}
