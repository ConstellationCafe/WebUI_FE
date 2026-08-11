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
        borderRadius: BorderRadius.circular(8),

        hoverColor: theme.colorScheme.onSurface.withOpacity(0.08),
        highlightColor: Colors.transparent,
        splashColor: theme.colorScheme.onSurface.withOpacity(0.12),

        child: Container(
          width: 180,
          height: 48, // 8의 배수로 변경
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primaryContainer
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: ConstSize.mediumSpacing),
          child: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: widget.iconImage,
              ),
              SizedBox(width: ConstSize.smallSpacing),
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