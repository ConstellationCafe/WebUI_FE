import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainSearchBar extends ConsumerStatefulWidget {
  const MainSearchBar({super.key});

  @override
  ConsumerState<MainSearchBar> createState() => _MainSearchBar();
}

class _MainSearchBar extends ConsumerState<MainSearchBar> {
  @override
  Widget build(BuildContext build) {
    GlobalKey formKey = GlobalKey();
    TextEditingController controller = TextEditingController();

    return Container(
      width: 180,
      height: 50,
      child: Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            filled: false,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey[700]!,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey[700]!,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.blue[300]!,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(build).colorScheme.onError,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(build).colorScheme.onError,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
