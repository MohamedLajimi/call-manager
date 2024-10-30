import 'package:call_me_app/bloc_observer.dart';
import 'package:call_me_app/core/routes/routes.dart';
import 'package:call_me_app/database/database_helper.dart';
import 'package:call_me_app/viewmodel/auth_bloc/auth_bloc.dart';
import 'package:call_me_app/viewmodel/contact_bloc/contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => AuthBloc(databaseHelper: DatabaseHelper()),
    ),
    BlocProvider(
      create: (context) => ContactBloc(databaseHelper: DatabaseHelper()),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
    );
  }
}
