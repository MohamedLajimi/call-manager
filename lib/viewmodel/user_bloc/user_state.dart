part of 'user_bloc.dart';

sealed class UserState  {
  const UserState();
  
}

final class UserInitial extends UserState {}

final class UserUnkown extends UserState {
  const UserUnkown();
}

final class UserLoading extends UserState{}

final class UserIsAuthenticated extends UserState {
  final User user;
  const UserIsAuthenticated(this.user);

}

final class UserIsNotAuthenticated extends UserState {
  const UserIsNotAuthenticated();
}
