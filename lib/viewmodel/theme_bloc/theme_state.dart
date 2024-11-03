part of 'theme_bloc.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

final class ThemeInitial extends ThemeState {}

class LoadingThemeState extends ThemeState {}

class LightThemeState extends ThemeState {
  final ThemeData themeData;
  const LightThemeState(this.themeData);
  @override
  List<Object> get props => [themeData];
}

class DarkThemeState extends ThemeState {
  final ThemeData themeData;
  const DarkThemeState(this.themeData);
  @override
  List<Object> get props => [themeData];
}
