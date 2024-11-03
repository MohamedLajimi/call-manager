import 'package:call_me_app/core/theme/theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LoadingThemeState()) {
    on<FetchTheme>((event, emit) async {
      const strorage = FlutterSecureStorage();
      if (event.theme == 'dark') {
        emit(DarkThemeState(darkTheme));
        await strorage.write(key: 'theme', value: 'dark');
      } else {
        emit(LightThemeState(lightTheme));
        await strorage.write(key: 'theme', value: 'light');
      }
    });

    on<ToggleTheme>((event, emit) async {
      const strorage = FlutterSecureStorage();
      if (event.theme == 'light') {
        emit(LightThemeState(lightTheme));
        await strorage.write(key: 'theme', value: 'light');
      } else {
        emit(DarkThemeState(darkTheme));
        await strorage.write(key: 'theme', value: 'dark');
      }
    });
  }
}
