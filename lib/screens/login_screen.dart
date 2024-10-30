// ignore_for_file: use_build_context_synchronously

import 'package:call_me_app/bloc_observer.dart';
import 'package:call_me_app/core/theme/app_palette.dart';
import 'package:call_me_app/core/utils/show_toast.dart';
import 'package:call_me_app/core/widgets/custom_app_bar.dart';
import 'package:call_me_app/core/widgets/custom_button.dart';
import 'package:call_me_app/core/widgets/custom_textfield.dart';
import 'package:call_me_app/database/database_helper.dart';
import 'package:call_me_app/viewmodel/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
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
            key: _loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter your email and your password to continue !',
                  style: GoogleFonts.poppins(
                      fontSize: 24,
                      color: AppPalette.primary,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Please enter a valid email and password to continue !',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 30,
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
                  height: 40,
                ),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is UserIsAuthenticated) {
                      context.go('/home-screen/${state.user.id}',extra: state.user.name);
                    }
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: CustomButton(
                        onPressed: () async {
                          if (_loginFormKey.currentState!.validate()) {
                            final user = await DatabaseHelper().loginUser(
                                emailController.text, passwordController.text);
                            if (user != null) {
                              context.read<AuthBloc>().add(SetUser(user));
                            } else {
                              showToast(message: 'Invalid credentials');
                            }
                          }
                        },
                        title: 'LOGIN',
                        backgroundColor: AppPalette.green),
                  ),
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
                          TextStyle(fontSize: 13, color: AppPalette.secondary),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () => context.push('/register-screen'),
                        child: const Text(
                          'Register Now',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 13),
                        ))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
