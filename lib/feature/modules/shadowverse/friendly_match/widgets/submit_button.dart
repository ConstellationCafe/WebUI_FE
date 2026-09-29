import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/shared/widgets/snack_bar/save_result_bar.dart';

import '../../constants/shadowverse_strings.dart';
import '../constants/friendly_match_constants.dart';
import '../notifier/friendly_match_notifier.dart';

class SubmitButton extends ConsumerStatefulWidget {
  const SubmitButton({super.key});

  @override
  ConsumerState<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends ConsumerState<SubmitButton> {
  /// 전송 중 중복 클릭을 막는 이 버튼만의 상태.
  bool _isLoading = false;

  Future<void> _onPressed() async {
    setState(() => _isLoading = true);
    try {
      final result = await ref.read(friendlyMatchProvider.notifier).submit();

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SaveResultBar.build(context, result));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SaveResultBar.build(context, ShadowverseStrings.submitFailed),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: FriendlyMatchConstants.submitBackground,
        foregroundColor: FriendlyMatchConstants.submitForeground,
        padding: const EdgeInsets.symmetric(
          vertical: FriendlyMatchConstants.submitVerticalPadding,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            FriendlyMatchConstants.submitRadius,
          ),
        ),
      ),
      child: _isLoading
          ? const SizedBox(
              height: FriendlyMatchConstants.submitProgressSize,
              width: FriendlyMatchConstants.submitProgressSize,
              child: CircularProgressIndicator(
                strokeWidth: FriendlyMatchConstants.submitProgressStrokeWidth,
              ),
            )
          : const Text(ShadowverseStrings.submit),
    );
  }
}
