import 'dart:io';
import 'package:call_me_app/core/utils/show_picture_bottom_sheet.dart';
import 'package:flutter/material.dart';

class UserImagePicker extends StatelessWidget {
  final File? picture;
  final VoidCallback selectImage;
  final VoidCallback deleteImage;
  const UserImagePicker(
      {super.key,
      required this.picture,
      required this.selectImage,
      required this.deleteImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: picture != null
                  ? FileImage(picture!)
                  : const AssetImage('assets/empty_profile_picture.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () {
              showPictureBottomSheet(
                  context: context,
                  onSelect: selectImage,
                  onDelete: deleteImage);
            },
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
