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
        super(AuthInitial()) {
    on<LoginUser>(
      (event, emit) async {
        emit(AuthLoading());
        final user =
            await _databaseHelper.loginUser(event.email, event.password);
        if (user != null) {
          const storage = FlutterSecureStorage();
          await storage.write(key: 'userId', value: user.id);
          emit(AuthSuccess(user));
        } else {
          emit(const AuthFailure('Invalid credentials'));
        }
      },
    );
    on<RegisterUser>(
      (event, emit) async {
        emit(AuthLoading());
        await _databaseHelper.registerUser(event.user);
        emit(AuthSuccess(event.user));
      },
    );
  }
}
