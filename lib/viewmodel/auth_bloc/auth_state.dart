part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final User user;
  const AuthSuccess(this.user);
  @override
  List<Object> get props => [user];
}

final class AuthFailure extends AuthState {
  final String error;
  const AuthFailure(this.error);
    @override
  List<Object> get props => [error];
}
