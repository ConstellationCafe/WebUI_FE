import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Enables Flutter's copy menu on web while a penalty page is mounted.
class PenaltyContextMenuScope extends StatefulWidget {
  final Widget child;

  const PenaltyContextMenuScope({super.key, required this.child});

  @override
  State<PenaltyContextMenuScope> createState() =>
      _PenaltyContextMenuScopeState();
}

class _PenaltyContextMenuScopeState extends State<PenaltyContextMenuScope> {
  static int _activeScopes = 0;
  static bool? _initiallyEnabled;
  static Future<void> _pending = Future<void>.value();

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) return;
    if (_activeScopes == 0 && _initiallyEnabled == null) {
      _initiallyEnabled = BrowserContextMenu.enabled;
    }
    _activeScopes++;
    _syncBrowserMenu();
  }

  @override
  void dispose() {
    if (kIsWeb) {
      _activeScopes--;
      _syncBrowserMenu();
    }
    super.dispose();
  }

  static void _syncBrowserMenu() {
    // BrowserContextMenu is global, so restore its original state after the
    // last penalty page has been removed.
    _pending = _pending.then((_) async {
      if (_activeScopes > 0 && BrowserContextMenu.enabled) {
        await BrowserContextMenu.disableContextMenu();
      } else if (_activeScopes == 0) {
        if (_initiallyEnabled == true && !BrowserContextMenu.enabled) {
          await BrowserContextMenu.enableContextMenu();
        }
        if (_activeScopes == 0) _initiallyEnabled = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
