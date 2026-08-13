import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

Page<void> noAnim(GoRouterState state, Widget child) {
  return NoTransitionPage<void>(
    key: state.pageKey,
    child: child,
  );
}