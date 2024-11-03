part of 'user_bloc.dart';

sealed class UserEvent {
  const UserEvent();
}

final class CheckUserState extends UserEvent {}

final class SetUser extends UserEvent {
  final User user;
  const SetUser(this.user);
}
