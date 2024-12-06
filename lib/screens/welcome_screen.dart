// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:call_me_app/core/theme/app_palette.dart';
import 'package:call_me_app/core/theme/theme.dart';
import 'package:call_me_app/core/widgets/custom_button.dart';
import 'package:call_me_app/core/widgets/theme_button.dart';
import 'package:call_me_app/viewmodel/theme_provider.dart';
import 'package:call_me_app/viewmodel/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/splash_image.png',
                height: MediaQuery.sizeOf(context).height * 0.4,
                width: MediaQuery.sizeOf(context).width,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Welcome To Contact Manager',
                style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                textAlign: TextAlign.center,
                'Discover exclusive contacts and manage them effortlessly. Everything you need is right at your fingertips !',
                style: TextStyle(fontSize: 13, color: AppPalette.lightGrey),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomButton(
                onPressed: () async {
                  final user =
                      await Provider.of<UserProvider>(context, listen: false)
                          .fetchUserData();
                  log(user.toString());
                  user != null
                      ? context.go('/home-screen')
                      : context.go('/login-screen');
                },
                title: 'START',
                backgroundColor: AppPalette.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
