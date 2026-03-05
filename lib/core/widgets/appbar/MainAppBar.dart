import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainAppBar extends ConsumerStatefulWidget {
  final bool showMenuButton;
  final VoidCallback? onMenuPressed;

  const MainAppBar({
    super.key,
    this.showMenuButton = false,
    this.onMenuPressed,
  });

  @override
  ConsumerState<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends ConsumerState<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 155,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (widget.showMenuButton)
            IconButton(
              onPressed: widget.onMenuPressed,
              icon: const Icon(Icons.menu, size: 30),
              tooltip: 'Menu',
            )
          else
            GestureDetector(
              onTap: () => context.go('/'),
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
          const Spacer(),
          const Text("섀버 별자리 Cafe"),
        ],
      ),
    );
  }
}
