import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/shared/widgets/snackBar/SaveResultBar.dart';

import '../../../core/constants/const_shadow.dart';
import '../constants/profile_constants.dart';
import '../notifier/membership_notifier.dart';
import 'save_membership_button.dart';

class InputMembershipData extends ConsumerStatefulWidget {
  final double width;

  const InputMembershipData({
    super.key,
    required this.width,
  });

  @override
  ConsumerState<InputMembershipData> createState() =>
      _InputMembershipDataState();
}

class _InputMembershipDataState extends ConsumerState<InputMembershipData> {
  final TextEditingController _uid1Controller = TextEditingController();
  final TextEditingController _uid2Controller = TextEditingController();
  final TextEditingController _guildController = TextEditingController();

  // 저장중인지를 나타내는 플래그
  bool _isLoading = false;

  @override
  void dispose() {
    _uid1Controller.dispose();
    _uid2Controller.dispose();
    _guildController.dispose();
    super.dispose();
  }

  // 저장 & 결과 표시
  Future<void> _onPressed() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final notifier = ref.read(membershipProvider.notifier);
      final results = await notifier.saveIfChanged();

      if (!mounted) return; // 저장하는 동안 페이지가 닫혔다면 여기서 종료

      await SaveResultBar.showAll(
        context,
        results,
        type: SaveResultType.success,
        durationPerBar: const Duration(seconds: 2),
        clearBefore: true,
      );
    } catch (e) {
      if (!mounted) return; // 저장하는 동안 페이지가 닫혔다면 여기서 종료

      ScaffoldMessenger.of(context).showSnackBar(
        SaveResultBar.build(
          context,
          '저장 중 오류 발생: $e',
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(membershipProvider.notifier);
    final theme = Theme.of(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: widget.width,
      ),
      child: Container(
        width: double.infinity,
        padding: ConstPadding.largePaddingAll,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(
            ProfileConstants.cardRadius,
          ),
          boxShadow: const [
            ConstShadow.card,
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _uid1Controller,
              decoration: const InputDecoration(
                labelText: 'UID1',
              ),
              onChanged: (value) {
                notifier.update(
                  uid1: value,
                );
              },
            ),
            const SizedBox(
              height: ConstSize.mediumSpacing,
            ),
            TextFormField(
              controller: _uid2Controller,
              decoration: const InputDecoration(
                labelText: 'UID2',
              ),
              onChanged: (value) {
                notifier.update(
                  uid2: value,
                );
              },
            ),
            const SizedBox(
              height: ConstSize.mediumSpacing,
            ),
            TextFormField(
              controller: _guildController,
              decoration: const InputDecoration(
                labelText: 'Guild',
              ),
              onChanged: (value) {
                notifier.update(
                  guild: value,
                );
              },
            ),
            const SizedBox(
              height: ConstSize.mediumSpacing,
            ),
            SaveMembershipButton(
              isLoading: _isLoading,
              onPressed: _onPressed,
            ),
          ],
        ),
      ),
    );
  }
}