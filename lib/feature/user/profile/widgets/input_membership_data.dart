// flutter
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Provider
import '../../../../core/widgets/snackBar/SaveResultBar.dart';
// Const
import 'package:constellation_cafe/core/constants/ConstPadding.dart';
import 'package:constellation_cafe/core/constants/ConstSize.dart';

import '../state/notifier/membership_notifier.dart';

class InputMembershipData extends ConsumerStatefulWidget {
  final double width;

  const InputMembershipData({
    super.key,
    required this.width
  });

  @override
  ConsumerState<InputMembershipData> createState() => _InputMembershipDataState();
}

class _InputMembershipDataState extends ConsumerState<InputMembershipData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _uid1Controller = TextEditingController();
  final TextEditingController _uid2Controller = TextEditingController();
  final TextEditingController _guildController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _uid1Controller.dispose();
    _uid2Controller.dispose();
    _guildController.dispose();
    super.dispose();
  }

  Future<void> _onPressed() async {
    setState(() => _isLoading = true);
    try {
      final notifier = ref.read(membershipProvider.notifier);
      final results = await notifier.saveIfChanged();
      if (!mounted) return;
      await SaveResultBar.showAll(
        context,
        results,
        type: SaveResultType.success,
        durationPerBar: const Duration(seconds: 2),
        clearBefore: true,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SaveResultBar.build(context, '저장 중 오류 발생: $e'),
      );
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) setState(() => _isLoading = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(membershipProvider.notifier);
    return SizedBox(
      width: widget.width,
      child: Container(
        padding: ConstPadding.largePaddingAll,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF000D27).withOpacity(0.12),  // rgba(0, 13, 39, 0.12)
              blurRadius: 24,                              // 24px 흐림
              offset: Offset(0, 8),                        // 0px x, 8px y
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _uid1Controller,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  labelText: 'UID1'
              ),
              onChanged: (value) {
                notifier.update(
                  uid1: value,
                );
              },
            ),
            const SizedBox(height: ConstSize.mediumSpacing),
            TextFormField(
              controller: _uid2Controller,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  labelText: 'UID2'
              ),
              onChanged: (value) {
                notifier.update(
                  uid2: value,
                );
              },
            ),
            const SizedBox(height: ConstSize.mediumSpacing),
            TextFormField(
              controller: _guildController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                labelText: 'Guild',
                contentPadding: ConstPadding.mediumPaddingAll,
              ),
              onChanged: (value) {
                notifier.update(
                  guild: value,
                );
              },
            ),
            const SizedBox(height: ConstSize.mediumSpacing),
            ElevatedButton(
              onPressed: _isLoading ? null : _onPressed,
              child: _isLoading
                  ? SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
                  : Text(
                    "저장",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
