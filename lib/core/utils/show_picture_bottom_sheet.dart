import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showPictureBottomSheet(
    {required BuildContext context,
    required VoidCallback onSelect,
    required VoidCallback onDelete}) {
  showBottomSheet(
    backgroundColor: Colors.black87,
    showDragHandle: true,
    constraints: BoxConstraints(
        maxHeight: 180, maxWidth: MediaQuery.sizeOf(context).width),
    context: context,
    builder: (context) {
      return Column(
        children: [
          ListTile(
            onTap: () {
              onSelect();
              context.pop();
            },
            leading: const Icon(
              Icons.image_outlined,
              color: Colors.white,
            ),
            title: const Text(
              'Choose picture from gallery',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          ListTile(
            onTap: () {
              onDelete();
              context.pop();
            },
            leading: const Icon(
              Icons.delete_outline,
              color: Colors.white,
            ),
            title: const Text(
              'Remove picture',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          )
        ],
      );
    },
  );
}
