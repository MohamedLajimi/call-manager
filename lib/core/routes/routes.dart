import 'package:call_me_app/models/contact.dart';
import 'package:call_me_app/screens/add_contact_screen.dart';
import 'package:call_me_app/screens/edit_contact_page.dart';
import 'package:call_me_app/screens/home_screen.dart';
import 'package:call_me_app/screens/localisation_screen.dart';
import 'package:call_me_app/screens/login_screen.dart';
import 'package:call_me_app/screens/profile_screen.dart';
import 'package:call_me_app/screens/register_screen.dart';
import 'package:call_me_app/screens/splash_screen.dart';
import 'package:call_me_app/screens/welcome_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: '/welcome-screen',
    builder: (context, state) => const WelcomeScreen(),
  ),
  GoRoute(
    path: '/login-screen',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/register-screen',
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
      path: '/home-screen',
      builder: (context, state) {
        return const HomeScreen();
      }),
  GoRoute(
      path: '/add-contact-screen',
      builder: (context, state) => const AddContactSceen()),
  GoRoute(
      path: '/edit-contact-screen',
      builder: (context, state) {
        final contact = state.extra as Contact;
        return EditContactScreen(
          contact: contact,
        );
      }),
  GoRoute(
      path: '/profile-screen',
      builder: (context, state) => const ProfileScreen()),
  GoRoute(
      path: '/localisation-screen',
      builder: (context, state) => const LocalisationScreen()),
]);
