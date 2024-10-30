import 'package:call_me_app/core/theme/app_palette.dart';
import 'package:call_me_app/core/widgets/custom_button.dart';
import 'package:call_me_app/viewmodel/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
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
                    fontSize: 22, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                textAlign: TextAlign.center,
                'Discover exclusive contacts and manage them effortlessly. Everything you need is right at your fingertips !',
                style: TextStyle(fontSize: 14, color: AppPalette.secondary),
              ),
              const SizedBox(
                height: 50,
              ),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is UserIsNotAuthenticated) {
                    context.go('/login-screen');
                  } else if (state is UserIsAuthenticated) {
                    context.go('/home-screen/${state.user.id}',extra: state.user.name);
                  }
                },
                child: CustomButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(CheckUserState());
                  },
                  title: 'LOGIN',
                  backgroundColor: AppPalette.green,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
