import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  final VoidCallback? onTap;

  const ProfileIcon({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // 기존 ProfileIcon 구현
        child: Icon(
          Icons.person,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}