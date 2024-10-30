part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

final class UserUnkown extends AuthState {
  const UserUnkown();
  @override
  List<Object> get props => [];
}

final class UserIsAuthenticated extends AuthState {
  final User user;
  const UserIsAuthenticated(this.user);
  @override
  List<Object> get props => [user];
}

final class UserIsNotAuthenticated extends AuthState {
  const UserIsNotAuthenticated();
  @override
  List<Object> get props => [];
}
