part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class LoginUser extends AuthEvent {
  final String email;
  final String password;

  const LoginUser({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

final class RegisterUser extends AuthEvent {
  final User user;

  const RegisterUser(this.user);
  @override
  List<Object> get props => [user];
}

final class LogoutUser extends AuthEvent {}
