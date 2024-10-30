import 'package:call_me_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onGoBack;
  final Widget title;
  const CustomAppBar({super.key, required this.onGoBack, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: onGoBack,
        icon: const Icon(
          Icons.keyboard_arrow_left,
          size: 30,
          color: AppPalette.primary,
        ),
      ),
      title: title,
      centerTitle: true,
    );
  }
}
