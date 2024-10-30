import 'dart:io';

import 'package:call_me_app/core/theme/app_palette.dart';
import 'package:call_me_app/models/contact.dart';
import 'package:flutter/material.dart';

class ContactListTile extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Contact contact;
  const ContactListTile(
      {super.key,
      required this.onEdit,
      required this.onDelete,
      required this.contact});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(3)),
      tileColor: Colors.grey.shade200,
      leading: Container(
        height: 100,
        width: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(image: FileImage(File(contact.picture)))),
      ),
      title: Text(
        contact.name,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        '+216 ${contact.phoneNumber}',
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppPalette.secondary),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  onEdit();
                },
                icon: const Icon(
                  Icons.edit,
                  size: 20,
                  color: AppPalette.green,
                )),
            IconButton(
                onPressed: () {
                  onDelete();
                },
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
