import 'package:call_me_app/database/database_helper.dart';
import 'package:call_me_app/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final DatabaseHelper _databaseHelper;
  UserBloc({required DatabaseHelper databaseHelper})
      : _databaseHelper = databaseHelper,
        super(UserInitial()) {
    on<CheckUserState>((event, emit) async {
      emit(UserLoading());
      final user = await _databaseHelper.getCurrentUser();
      user != null
          ? emit(UserIsAuthenticated(user))
          : emit(const UserIsNotAuthenticated());
    });
    on<SetUser>((event, emit) async {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'userId', value: event.user.id);
      final User appUser = User(
          id: event.user.id,
          name: event.user.name,
          email: event.user.email,
          password: event.user.password,
          phoneNumber: event.user.phoneNumber,
          picture: event.user.picture);
      emit(UserIsAuthenticated(appUser));
    });
  }
}
