import 'package:call_me_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback onPressed;
  const AppBarButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        style: ButtonStyle(
            fixedSize: const WidgetStatePropertyAll(Size(45, 30)),
            shape: WidgetStatePropertyAll(
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(3))),
            side: const WidgetStatePropertyAll(
                BorderSide(color: AppPalette.lightGrey, width: 0.1))),
        icon: icon);
  }
}
