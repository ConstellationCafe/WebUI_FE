import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:constellation_cafe/core/constants/ConstSize.dart';

class MenuContainer extends ConsumerStatefulWidget {
  final Image iconImage;
  final String menuName;
  final String callbackUrl;

  const MenuContainer({
    super.key,
    required this.iconImage,
    required this.menuName,
    required this.callbackUrl,
  });

  @override
  ConsumerState<MenuContainer> createState() => _MenuContainerState();
}

class _MenuContainerState extends ConsumerState<MenuContainer> {
  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    final bool isSelected = location == widget.callbackUrl;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Drawer가 열려있으면 닫기
          if (Scaffold.of(context).isDrawerOpen) {
            Navigator.of(context).pop();
          }
          context.go(widget.callbackUrl);
        },
        borderRadius: BorderRadius.circular(6),

        hoverColor: Colors.grey.withOpacity(0.15),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,

        child: Container(
          width: 180,
          height: 40,
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.grey.withOpacity(0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: widget.iconImage,
              ),
              const SizedBox(width: ConstSize.smallWidth),
              Text(
                widget.menuName,
                style: TextStyle(
                  fontSize: ConstSize.bigTextSize,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}