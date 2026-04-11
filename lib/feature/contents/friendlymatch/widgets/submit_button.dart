import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/ApiProvider.dart';
import '../../../../core/widgets/snackBar/SaveResultBar.dart';
import '../../../../domain/friendly_match/friendly_match_template.dart';
import '../state/Notifier/friendly_match_notifier.dart';


class SubmitButton extends ConsumerStatefulWidget {
  const SubmitButton({super.key});

  @override
  ConsumerState<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends ConsumerState<SubmitButton> {
  bool _isLoading = false;

  FriendlyMatchTemplate toTemplate() {
    final state = ref.read(friendlyMatchProvider);
    return FriendlyMatchTemplate(
      version: state.version,
      mode: state.mode,
      platform: state.platform,
      roomNumber: state.roomNumber,
      message: state.message,
      sender: state.sender,
    );
  }

  Future<void> _onPressed() async {
    final api = ref.read(shadowverseApiProvider);
    setState(() => _isLoading = true);
    try {
      final template = toTemplate();
      final result = await api.friedlyMatch(
        FriendlyMatchTemplate.toJson(template).args,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SaveResultBar.build(context, result),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SaveResultBar.build(context, "전송 실패 : $e"),
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
        backgroundColor: const Color(0xFF444444),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: _isLoading
          ? const SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(strokeWidth: 2),
      )
          : const Text('전송'),
    );
  }
}