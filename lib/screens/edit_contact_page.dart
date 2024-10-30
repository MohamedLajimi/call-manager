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
import 'package:call_me_app/viewmodel/auth_bloc/auth_bloc.dart';
import 'package:call_me_app/viewmodel/contact_bloc/contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditContactScreen extends StatefulWidget {
  final Contact contact;
  const EditContactScreen({super.key, required this.contact});

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  final _editContactFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  String oldPhoneNumber = '';
  File? picture;

  @override
  void initState() {
    super.initState();
    _getContactData();
  }

  void _getContactData() {
    nameController.text = widget.contact.name;
    phoneNumberController.text = widget.contact.phoneNumber;
    oldPhoneNumber = widget.contact.phoneNumber;
    picture = File(widget.contact.picture);
  }

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
              color: AppPalette.secondary,
            )),
        title: const Text(
          'Edit Contact',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Form(
            key: _editContactFormKey,
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
                const Text(
                  'Full Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
                const Text(
                  'Phone Number',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
                        if (_editContactFormKey.currentState!.validate()) {
                          final contact = Contact(
                            userId: (context.read<AuthBloc>().state
                                    as UserIsAuthenticated)
                                .user
                                .id,
                            name: nameController.text,
                            phoneNumber: phoneNumberController.text,
                            picture: picture!.path,
                          );
                          DatabaseHelper().editContact(
                            contact,oldPhoneNumber
                          );
                          context.pushReplacement(
                              '/home-screen/${contact.userId}', extra: () {
                            context
                                .read<ContactBloc>()
                                .add(FetchContacts(userId: contact.userId));
                          });

                          showToast(message: 'Contact edited successfully');
                        }
                      },
                      title: 'EDIT CONTACT',
                      backgroundColor: AppPalette.green),
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