import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/feature/home/constants/home_constants.dart';

class MenuContainer extends ConsumerStatefulWidget {
  final Widget iconImage;
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
    final theme = Theme.of(context);

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
        borderRadius: BorderRadius.circular(HomeConstants.menuItemRadius),

        hoverColor: theme.colorScheme.onSurface.withValues(
          alpha: HomeConstants.menuHoverOpacity,
        ),
        highlightColor: Colors.transparent,
        splashColor: theme.colorScheme.onSurface.withValues(
          alpha: HomeConstants.menuSplashOpacity,
        ),

        child: Container(
          width: HomeConstants.menuWidth,
          height: HomeConstants.menuItemHeight,
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primaryContainer
                : Colors.transparent,
            borderRadius: BorderRadius.circular(HomeConstants.menuItemRadius),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: ConstSize.mediumSpacing,
          ),
          child: Row(
            children: [
              SizedBox(
                width: HomeConstants.menuItemIconSize,
                height: HomeConstants.menuItemIconSize,
                child: widget.iconImage,
              ),
              const SizedBox(width: ConstSize.smallSpacing),
              Text(
                widget.menuName,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: isSelected
                      ? theme.colorScheme.onPrimaryContainer
                      : theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
