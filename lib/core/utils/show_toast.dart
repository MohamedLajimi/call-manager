import 'package:call_me_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToast(
    {required String message,
    required BuildContext context,
    required ToastificationType type}) {
  toastification.show(
      alignment: Alignment.bottomCenter,
      borderRadius: BorderRadius.circular(5),
      type: type,
      showProgressBar: false,
      title: Text(
        message,
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary, fontSize: 14),
      ),
      icon: type == ToastificationType.error
          ? const Icon(
              Icons.error_outline,
              color: AppPalette.red,
            )
          : const Icon(
              Icons.done,
              color: AppPalette.green,
            ),
      showIcon: true,
      autoCloseDuration: const Duration(seconds: 3),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      style: ToastificationStyle.minimal,
      borderSide: const BorderSide(color: AppPalette.borderColor, width: 0.3));
}
