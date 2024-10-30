import 'dart:developer';

import 'package:call_me_app/database/database_helper.dart';
import 'package:call_me_app/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final DatabaseHelper _databaseHelper;
  AuthBloc({required DatabaseHelper databaseHelper})
      : _databaseHelper = databaseHelper,
        super(const UserUnkown()) {
    on<CheckUserState>((event, emit) async {
      final user = await _databaseHelper.getCurrentUser();
      log(user.toString());
      user != null
          ? emit(UserIsAuthenticated(user))
          : emit(const UserIsNotAuthenticated());
    });
    on<SetUser>((event, emit) async {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'userId', value: event.user.id);
      emit(UserIsAuthenticated(event.user));
    });
  }
}
