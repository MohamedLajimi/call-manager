import 'package:call_me_app/database/database_helper.dart';
import 'package:call_me_app/viewmodel/auth_bloc/auth_bloc.dart';
import 'package:call_me_app/viewmodel/contact_bloc/contact_bloc.dart';
import 'package:call_me_app/viewmodel/user_bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Auth dependencies
  serviceLocator.registerLazySingleton<DatabaseHelper>(
    () => DatabaseHelper(),
  );
  serviceLocator.registerLazySingleton(
    () => AuthBloc(databaseHelper: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => UserBloc(databaseHelper: serviceLocator()),
  );

  // Contact dependencies

  serviceLocator.registerFactory<ContactBloc>(
    () => ContactBloc(databaseHelper: serviceLocator()),
  );
}
