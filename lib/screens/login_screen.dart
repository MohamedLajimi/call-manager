// ignore_for_file: use_build_context_synchronously

import 'package:call_me_app/core/theme/app_palette.dart';
import 'package:call_me_app/core/theme/theme.dart';
import 'package:call_me_app/core/utils/show_toast.dart';
import 'package:call_me_app/core/widgets/custom_button.dart';
import 'package:call_me_app/core/widgets/custom_textfield.dart';
import 'package:call_me_app/core/widgets/theme_button.dart';
import 'package:call_me_app/viewmodel/auth_provider.dart';
import 'package:call_me_app/viewmodel/theme_provider.dart';
import 'package:call_me_app/viewmodel/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscureText = true;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Form(
            key: _loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi There ! Login or create a new account if you don\'t have a one .',
                  style: GoogleFonts.poppins(
                      fontSize: 19,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Please enter a valid email and password to continue !',
                  style: TextStyle(fontSize: 14, color: AppPalette.lightGrey),
                ),
                const SizedBox(
                  height: 30,
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
                  height: 20,
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
                  height: 40,
                ),
                Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                      onPressed: () async {
                        if (_loginFormKey.currentState!.validate()) {
                          final res = await Provider.of<AuthProvider>(context,
                                  listen: false)
                              .loginUser(
                                  email: emailController.text,
                                  password: passwordController.text);
                          res.fold(
                            (l) => showToast(
                                message: l,
                                context: context,
                                type: ToastificationType.error),
                            (r) {
                              Provider.of<UserProvider>(context, listen: false)
                                  .setUser(r);
                              context.go('/home-screen');
                            },
                          );
                        }
                      },
                      title: 'LOGIN',
                      backgroundColor: AppPalette.blue),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account ?',
                      style:
                          TextStyle(fontSize: 13, color: AppPalette.lightGrey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () => context.push('/register-screen'),
                        child: Text(
                          'Register Now',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.primary),
                        ))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
