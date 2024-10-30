import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color backgroundColor;
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            fixedSize: const WidgetStatePropertyAll(Size(180, 50)),
            shape: WidgetStatePropertyAll(
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(3))),
            backgroundColor: WidgetStatePropertyAll(backgroundColor)),
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
        ));
  }
}
