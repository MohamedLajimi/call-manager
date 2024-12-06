import 'dart:io';

import 'package:call_me_app/core/theme/theme.dart';
import 'package:call_me_app/core/widgets/theme_button.dart';
import 'package:call_me_app/core/widgets/user_data_tile.dart';
import 'package:call_me_app/viewmodel/auth_provider.dart';
import 'package:call_me_app/viewmodel/theme_provider.dart';
import 'package:call_me_app/viewmodel/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
          AppBarButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            icon: Provider.of<ThemeProvider>(context).theme == lightTheme
                ? const Icon(
                    Icons.light_mode_outlined,
                    size: 15,
                  )
                : const Icon(
                    Icons.dark_mode_outlined,
                    size: 15,
                  ),
          ),
          const SizedBox(width: 10),
          AppBarButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false)
                  .logoutUser(context: context);
            },
            icon: Icon(
              Icons.logout,
              size: 15,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: FileImage(File(user.picture)),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: 30),
              UserDataTile(
                  icon: const Icon(Icons.person_outline),
                  label: 'Full Name',
                  data: user.name),
              const SizedBox(
                height: 10,
              ),
              UserDataTile(
                  icon: const Icon(Icons.email_outlined),
                  label: 'Email',
                  data: user.email),
              const SizedBox(
                height: 10,
              ),
              UserDataTile(
                  icon: const Icon(Icons.phone_outlined),
                  label: 'Phone Number',
                  data: user.phoneNumber),
            ],
          ),
        ),
      ),
    );
  }
}
