// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:call_me_app/core/theme/app_palette.dart';
import 'package:call_me_app/core/utils/pick_image.dart';
import 'package:call_me_app/core/widgets/custom_app_bar.dart';
import 'package:call_me_app/core/widgets/custom_button.dart';
import 'package:call_me_app/core/widgets/custom_textfield.dart';
import 'package:call_me_app/core/widgets/user_image_picker.dart';
import 'package:call_me_app/database/database_helper.dart';
import 'package:call_me_app/models/user.dart';
import 'package:call_me_app/viewmodel/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registerFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
              onGoBack: () {
                context.pop();
              },
              title: Image.asset(
                'assets/app_logo.png',
                height: 80,
                width: 80,
              ))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Form(
            key: _registerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter your personal data to create a new account !',
                  style: GoogleFonts.poppins(
                      fontSize: 24,
                      color: AppPalette.primary,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 30,
                ),
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
                    hintText: 'Enter Your name'),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Email',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextfield(
                    inputType: TextInputType.emailAddress,
                    controller: emailController,
                    hintText: 'Enter Your Email'),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextfield(
                    inputType: TextInputType.text,
                    controller: passwordController,
                    hintText: 'Enter Your Password'),
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
                    hintText: 'Enter Your Phone Number'),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                      onPressed: () async {
                        if (_registerFormKey.currentState!.validate()) {
                          final user = User(
                            id: const Uuid().v4(),
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            phoneNumber: phoneNumberController.text,
                            picture: picture!.path,
                          );
                          await DatabaseHelper().registerUser(user);
                          context.read<AuthBloc>().add(SetUser(user));

                          context.go('/home-screen/${user.id}',extra: user.name);
                        }
                      },
                      title: 'REGISTER',
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
