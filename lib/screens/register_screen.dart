// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:call_me_app/core/theme/app_palette.dart';
import 'package:call_me_app/core/theme/theme.dart';
import 'package:call_me_app/core/utils/pick_image.dart';
import 'package:call_me_app/core/utils/show_toast.dart';
import 'package:call_me_app/core/widgets/custom_button.dart';
import 'package:call_me_app/core/widgets/custom_textfield.dart';
import 'package:call_me_app/core/widgets/theme_button.dart';
import 'package:call_me_app/core/widgets/user_image_picker.dart';
import 'package:call_me_app/models/user.dart';
import 'package:call_me_app/viewmodel/auth_provider.dart';
import 'package:call_me_app/viewmodel/theme_provider.dart';
import 'package:call_me_app/viewmodel/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
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
  bool obscureText = true;

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
        centerTitle: true,
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Theme.of(context).colorScheme.primary,
            )),
        title: ColorFiltered(
            colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary, BlendMode.srcIn),
            child: Image.asset(
              width: 80,
              height: 80,
              'assets/app_logo.png',
            )),
        actions: [
          AppBarButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            icon: Provider.of<ThemeProvider>(context).theme == lightTheme
                ? const Icon(
                    Icons.light_mode_outlined,
                    size: 20,
                  )
                : const Icon(
                    Icons.dark_mode_outlined,
                    size: 20,
                  ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
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
                      fontSize: 19,
                      color: Theme.of(context).colorScheme.primary,
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
                Text(
                  'Full Name',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextfield(
                    inputType: TextInputType.name,
                    controller: nameController,
                    hintText: 'Enter Your name'),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Email',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextfield(
                    inputType: TextInputType.emailAddress,
                    controller: emailController,
                    hintText: 'Enter Your Email'),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Password',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextfield(
                    obscureText: obscureText,
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    inputType: TextInputType.text,
                    controller: passwordController,
                    hintText: 'Enter Your Password'),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Phone Number',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary),
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
                          Provider.of<AuthProvider>(context, listen: false)
                              .registerUser(user: user);
                          Provider.of<UserProvider>(context, listen: false)
                              .setUser(user);
                          showToast(
                              message: 'Account created successfully.',
                              context: context,
                              type: ToastificationType.success);
                          context.go('/home-screen');
                        }
                      },
                      title: 'REGISTER',
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
