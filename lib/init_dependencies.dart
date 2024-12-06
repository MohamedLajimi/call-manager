import 'package:call_me_app/database/database_helper.dart';
import 'package:call_me_app/viewmodel/auth_provider.dart';
import 'package:call_me_app/viewmodel/contact_provider.dart';
import 'package:call_me_app/viewmodel/theme_provider.dart';
import 'package:call_me_app/viewmodel/user_provider.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Database dependencies
  serviceLocator.registerLazySingleton<DatabaseHelper>(
    () => DatabaseHelper(),
  );

  // Theme dependency

  serviceLocator.registerLazySingleton<ThemeProvider>(
    () => ThemeProvider(),
  );

  // Auth dependencies
  serviceLocator.registerLazySingleton(
      () => AuthProvider(databaseHelper: serviceLocator()));
  serviceLocator.registerLazySingleton(() => UserProvider(serviceLocator()));

  // Contact dependencies
  serviceLocator.registerFactory(
    () => ContactProvider(serviceLocator()),
  );
}
