part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class CheckUserState extends AuthEvent {}

final class SetUser extends AuthEvent {
  final User user;
  const SetUser(this.user);
  @override
  List<Object> get props => [];
}
