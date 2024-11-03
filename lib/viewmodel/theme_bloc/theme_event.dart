part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class FetchTheme extends ThemeEvent {
  final String theme;
  const FetchTheme(this.theme);
    @override
  List<Object> get props => [theme];
}

class ToggleTheme extends ThemeEvent {
  final String theme;
  const ToggleTheme(this.theme);
    @override
  List<Object> get props => [theme];
}
