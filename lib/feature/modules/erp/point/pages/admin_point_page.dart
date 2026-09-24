import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/point_strings.dart';
import '../constants/point_tokens.dart';
import '../notifier/admin_point_notifier.dart';
import '../widgets/member_list_panel.dart';
import '../widgets/member_point_detail.dart';
import '../widgets/point_transaction_dialog.dart';

part 'admin_point_page_state.dart';

class AdminPointPage extends ConsumerStatefulWidget {
  const AdminPointPage({super.key});

  @override
  ConsumerState<AdminPointPage> createState() => _AdminPointPageState();
}
