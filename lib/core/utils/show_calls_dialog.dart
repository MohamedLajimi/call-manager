import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:call_me_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showCallsDialog(
    {required BuildContext context,
    required VoidCallback onSendMessage,
    required VoidCallback onCall}) {
  AwesomeDialog(
          dialogBackgroundColor: Theme.of(context).colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          context: context,
          animType: AnimType.bottomSlide,
          dialogType: DialogType.noHeader,
          titleTextStyle: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary),
          descTextStyle:
              const TextStyle(fontSize: 14, color: AppPalette.lightGrey),
          title: 'ACTIONS',
          desc: 'Make a phone call or send a message.',
          btnCancelOnPress: onSendMessage,
          btnOkOnPress: onCall,
          btnOkText: 'CALL',
          btnCancelText: 'SMS',
          buttonsTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
          btnOkColor: AppPalette.green,
          btnCancelColor: AppPalette.blue)
      .show();
}
