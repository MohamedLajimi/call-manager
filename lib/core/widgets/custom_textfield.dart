
import 'package:call_me_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? inputType;
  const CustomTextfield(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.inputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required ${hintText.split(' ').last}';
        }
        return null;
      },
      keyboardType: inputType,
      style: const TextStyle(fontSize: 12),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: AppPalette.secondary, fontSize: 14),
          errorStyle: const TextStyle(fontSize: 12, color: Colors.red),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.3, color: Colors.red),
              borderRadius: BorderRadius.circular(5)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.3, color: Colors.red),
              borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(width: 0.5, color: AppPalette.borderColor),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 0.3, color: AppPalette.borderColor),
              borderRadius: BorderRadius.circular(5)),
          enabled: true),
    );
  }
}
