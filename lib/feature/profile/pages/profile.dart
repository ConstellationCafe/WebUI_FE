import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/screen_width.dart';
import 'package:constellation_cafe/shared/widgets/loading/page_loading.dart';
import 'package:constellation_cafe/shared/widgets/usage/usage.dart';

import '../notifier/membership_notifier.dart';
import '../widgets/profile_layout.dart';
import '../widgets/profile_load_error.dart';
import '../widgets/profile_usage.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  final GlobalKey membershipCardKey = GlobalKey();
  final GlobalKey pointLogButtonKey = GlobalKey();
  final GlobalKey inputDataKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(membershipProvider.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(membershipProvider);

    if (state.isLoading) {
      return const PageLoading();
    }

    if (state.hasError) {
      return ProfileLoadError(
        onRetry: () => ref.read(membershipProvider.notifier).initialize(),
      );
    }

    return Center(
      child: Usage(
        usageKey: ProfileUsage.key,
        steps: ProfileUsage.steps(
          pointLogButtonKey: pointLogButtonKey,
          inputDataKey: inputDataKey,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = ScreenWidth.isDesktop(constraints.maxWidth);

            return SingleChildScrollView(
              child: ProfileLayout(
                isDesktop: isDesktop,
                membershipCardKey: membershipCardKey,
                pointLogButtonKey: pointLogButtonKey,
                inputDataKey: inputDataKey,
              ),
            );
          },
        ),
      ),
    );
  }
}
