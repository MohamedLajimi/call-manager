import 'package:call_me_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class UserDataTile extends StatelessWidget {
  final Icon icon;
  final String label;
  final String data;
  const UserDataTile(
      {super.key, required this.icon, required this.label, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(3),
          side: const BorderSide(color: AppPalette.lightGrey, width: 0.1)),
      leading: icon,
      title: Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        data,
        style: const TextStyle(fontSize: 12, color: AppPalette.lightGrey),
      ),
    );
  }
}
