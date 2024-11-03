// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:call_me_app/core/theme/app_palette.dart';
import 'package:call_me_app/core/utils/pick_image.dart';
import 'package:call_me_app/core/utils/show_toast.dart';
import 'package:call_me_app/core/widgets/custom_button.dart';
import 'package:call_me_app/core/widgets/custom_textfield.dart';
import 'package:call_me_app/core/widgets/user_image_picker.dart';
import 'package:call_me_app/database/database_helper.dart';
import 'package:call_me_app/models/contact.dart';
import 'package:call_me_app/viewmodel/contact_bloc/contact_bloc.dart';
import 'package:call_me_app/viewmodel/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class AddContactSceen extends StatefulWidget {
  const AddContactSceen({super.key});

  @override
  State<AddContactSceen> createState() => _AddContactSceenState();
}

class _AddContactSceenState extends State<AddContactSceen> {
  final _addContactFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  File? picture;

  void _selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        picture = pickedImage;
      });
    }
  }

  void _deleteImage() async {
    setState(() {
      picture = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.keyboard_arrow_left,
              color: AppPalette.lightGrey,
            )),
        title: const Text(
          'Add Contact',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Form(
            key: _addContactFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: UserImagePicker(
                      picture: picture,
                      selectImage: _selectImage,
                      deleteImage: _deleteImage),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Full Name',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextfield(
                    inputType: TextInputType.name,
                    controller: nameController,
                    hintText: 'Enter Name'),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Phone Number',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextfield(
                    inputType: TextInputType.phone,
                    controller: phoneNumberController,
                    hintText: 'Enter Phone Number'),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                      onPressed: () async {
                        if (_addContactFormKey.currentState!.validate()) {
                          final contact = Contact(
                            userId: (context.read<UserBloc>().state
                                    as UserIsAuthenticated)
                                .user
                                .id,
                            name: nameController.text,
                            phoneNumber: phoneNumberController.text,
                            picture: picture!.path,
                          );
                          await DatabaseHelper().addContact(contact);
                          context.pushReplacement(
                              '/home-screen/${contact.userId}', extra: () {
                            context
                                .read<ContactBloc>()
                                .add(FetchContacts(userId: contact.userId));
                          });

                          showToast(
                              message: 'Contact created successfully',
                              context: context,
                              type: ToastificationType.success);
                        }
                      },
                      title: 'ADD CONTACT',
                      backgroundColor: AppPalette.blue),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            )),
      ),
    );
  }
}
