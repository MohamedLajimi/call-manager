import 'package:call_me_app/core/routes/routes.dart';
import 'package:call_me_app/init_dependencies.dart';
import 'package:call_me_app/services/localisation_service.dart';
import 'package:call_me_app/viewmodel/auth_provider.dart';
import 'package:call_me_app/viewmodel/contact_provider.dart';
import 'package:call_me_app/viewmodel/localisation_provider.dart';
import 'package:call_me_app/viewmodel/theme_provider.dart';
import 'package:call_me_app/viewmodel/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => serviceLocator<UserProvider>(),
    ),
    ChangeNotifierProvider(
      create: (context) => serviceLocator<ThemeProvider>(),
    ),
    ChangeNotifierProvider(
      create: (context) => serviceLocator<AuthProvider>(),
    ),
    ChangeNotifierProvider(
      create: (context) => serviceLocator<ContactProvider>(),
    ),
    ChangeNotifierProvider(
      create: (context) => LocalisationProvider(LocalisationService()),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        title: 'Flutter Demo',
        theme: Provider.of<ThemeProvider>(context).theme,
      ),
    );
  }
}
