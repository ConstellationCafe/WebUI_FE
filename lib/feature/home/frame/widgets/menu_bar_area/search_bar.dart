import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/feature/home/constants/home_constants.dart';

class MainSearchBar extends StatefulWidget {
  const MainSearchBar({super.key});

  @override
  State<MainSearchBar> createState() => _MainSearchBarState();
}

class _MainSearchBarState extends State<MainSearchBar> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static OutlineInputBorder _border(Color color, double width) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(HomeConstants.searchFieldRadius),
        borderSide: BorderSide(color: color, width: width),
      );

  @override
  Widget build(BuildContext context) {
    final errorColor = Theme.of(context).colorScheme.onError;

    return SizedBox(
      width: HomeConstants.searchBarWidth,
      height: HomeConstants.searchBarHeight,
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          style: const TextStyle(
            color: HomeConstants.searchText,
            fontSize: ConstSize.mediumTextSize,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            filled: false,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: HomeConstants.searchFieldHorizontalPadding,
              vertical: HomeConstants.searchFieldVerticalPadding,
            ),
            border: _border(
              HomeConstants.searchBorder,
              HomeConstants.searchBorderWidth,
            ),
            enabledBorder: _border(
              HomeConstants.searchBorder,
              HomeConstants.searchBorderWidth,
            ),
            focusedBorder: _border(
              HomeConstants.searchFocusedBorder,
              HomeConstants.searchFocusedBorderWidth,
            ),
            errorBorder: _border(errorColor, HomeConstants.searchBorderWidth),
            focusedErrorBorder: _border(
              errorColor,
              HomeConstants.searchFocusedBorderWidth,
            ),
          ),
        ),
      ),
    );
  }
}
