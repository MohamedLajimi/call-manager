import 'package:call_me_app/database/database_helper.dart';
import 'package:call_me_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

const storage = FlutterSecureStorage();

class AuthProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;
  AuthProvider({required this.databaseHelper});
  Future<Either<String, User>> loginUser(
      {required String email, required String password}) async {
    final res = await databaseHelper.loginUser(email, password);
    if (res != null) {
      storage.write(key: 'userId', value: res.id);
      return right(res);
    } else {
      return left('Invalid crendentials');
    }
  }

  Future<void> registerUser({required User user}) async {
    await databaseHelper.registerUser(user);

    storage.write(key: 'userId', value: user.id);
  }

  void logoutUser({required BuildContext context}) {
    const storage = FlutterSecureStorage();
    storage.delete(key: 'userId');
    context.go('/login-screen');
  }
}
