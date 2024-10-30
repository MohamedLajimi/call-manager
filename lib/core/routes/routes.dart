import 'package:call_me_app/database/database_helper.dart';
import 'package:call_me_app/models/contact.dart';
import 'package:call_me_app/screens/add_contact_screen.dart';
import 'package:call_me_app/screens/edit_contact_page.dart';
import 'package:call_me_app/screens/home_screen.dart';
import 'package:call_me_app/screens/login_screen.dart';
import 'package:call_me_app/screens/register_screen.dart';
import 'package:call_me_app/screens/splash_screen.dart';
import 'package:call_me_app/screens/welcome_screen.dart';
import 'package:call_me_app/viewmodel/contact_bloc/contact_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      path: '/home-screen/:id',
      builder: (context, state) {
        final userId = state.pathParameters['id'] as String;
        return BlocProvider(
          create: (context) => ContactBloc(databaseHelper: DatabaseHelper())
            ..add(FetchContacts(userId: userId)),
          child: const HomeScreen(),
        );
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
      })
]);
