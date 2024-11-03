import 'dart:io';

import 'package:call_me_app/core/theme/app_palette.dart';
import 'package:call_me_app/models/contact.dart';
import 'package:flutter/material.dart';

class ContactListTile extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Contact contact;
  final VoidCallback onTap;
  const ContactListTile(
      {super.key,
      required this.onEdit,
      required this.onDelete,
      required this.onTap,
      required this.contact});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(),
      contentPadding: const EdgeInsets.all(0),
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(3)),
      leading: CircleAvatar(
        backgroundImage: FileImage(File(contact.picture)),
      ),
      title: Text(
        contact.name,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        '+216 ${contact.phoneNumber}',
        style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppPalette.lightGrey),
      ),
      trailing: SizedBox(
        width: 108,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  onEdit();
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        AppPalette.blue.withOpacity(0.2))),
                icon: Icon(
                  Icons.edit,
                  size: 20,
                  color: AppPalette.blue,
                )),
            const SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: () {
                  onDelete();
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        AppPalette.red.withOpacity(0.2))),
                icon: const Icon(
                  Icons.delete_outline,
                  size: 20,
                  color: AppPalette.red,
                ))
          ],
        ),
      ),
    );
  }
}
