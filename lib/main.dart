import 'package:call_me_app/bloc_observer.dart';
import 'package:call_me_app/core/routes/routes.dart';
import 'package:call_me_app/core/theme/theme.dart';
import 'package:call_me_app/init_dependencies.dart';
import 'package:call_me_app/viewmodel/auth_bloc/auth_bloc.dart';
import 'package:call_me_app/viewmodel/contact_bloc/contact_bloc.dart';
import 'package:call_me_app/viewmodel/theme_bloc/theme_bloc.dart';
import 'package:call_me_app/viewmodel/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  const storage = FlutterSecureStorage();
  final String theme = await storage.read(key: 'theme') ?? 'light';
  Bloc.observer = SimpleBlocObserver();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => ThemeBloc()..add(FetchTheme(theme)),
    ),
    BlocProvider(
      create: (context) => serviceLocator<AuthBloc>(),
    ),
    BlocProvider(
      create: (context) => serviceLocator<UserBloc>(),
    ),
    BlocProvider(
      create: (context) => serviceLocator<ContactBloc>(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return ToastificationWrapper(
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            title: 'Flutter Demo',
            theme: state is LightThemeState ? lightTheme : darkTheme,
          ),
        );
      },
    );
  }
}
