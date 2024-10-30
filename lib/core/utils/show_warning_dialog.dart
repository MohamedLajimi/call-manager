import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:call_me_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showWarningDialog(
    {required BuildContext context,
    required String title,
    required String desc,
    required String btnOkText,
    required String btnCancelText,
    required VoidCallback onConfirm}) {
  AwesomeDialog(
          dialogBackgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          context: context,
          animType: AnimType.bottomSlide,
          dialogType: DialogType.noHeader,
          titleTextStyle: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
          descTextStyle:
              const TextStyle(fontSize: 14, color: AppPalette.secondary),
          title: title,
          desc: desc,
          btnCancelOnPress: () {},
          btnOkOnPress: onConfirm,
          btnOkText: btnOkText,
          buttonsTextStyle: const TextStyle(color: Colors.white),
          btnCancelText: btnCancelText,
          btnOkColor: Colors.red,
          btnCancelColor: Colors.blueAccent)
      .show();
}
