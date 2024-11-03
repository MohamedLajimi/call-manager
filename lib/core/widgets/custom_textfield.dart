import 'package:call_me_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? inputType;
  final bool? obscureText;
  final VoidCallback? onTap;
  const CustomTextfield(
      {super.key,
      required this.controller,
      this.obscureText,
      this.onTap,
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
      obscureText: obscureText ?? false,
      style:
          TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary),
      decoration: InputDecoration(
          suffixIcon: hintText == 'Enter Your Password'
              ? IconButton(
                  onPressed: onTap,
                  icon: Icon(
                    obscureText != null && !obscureText!
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppPalette.lightGrey,
                  ))
              : const SizedBox(),
          hintText: hintText,
          hintStyle: const TextStyle(color: AppPalette.lightGrey, fontSize: 14),
          errorStyle: const TextStyle(fontSize: 12, color: Colors.red),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.3, color: Colors.red),
              borderRadius: BorderRadius.circular(5)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.3, color: Colors.red),
              borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.4, color: AppPalette.blue),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 0.4, color: AppPalette.borderColor),
              borderRadius: BorderRadius.circular(5)),
          enabled: true),
    );
  }
}
