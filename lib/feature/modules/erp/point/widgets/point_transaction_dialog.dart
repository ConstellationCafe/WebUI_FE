import 'package:flutter/material.dart';

import '../constants/point_strings.dart';
import '../domain/model/point_member.dart';

part 'point_transaction_dialog_state.dart';

class PointTransactionDialog extends StatefulWidget {
  final bool isDeposit;
  final PointMember member;
  final Future<bool> Function(int amount, String description) onSubmit;

  const PointTransactionDialog({
    super.key,
    required this.isDeposit,
    required this.member,
    required this.onSubmit,
  });

  @override
  State<PointTransactionDialog> createState() => _PointTransactionDialogState();
}
