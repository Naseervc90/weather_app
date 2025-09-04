import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Theme Events
abstract class ThemeEvent {}

class ThemeToggled extends ThemeEvent {}

class ThemeInitialized extends ThemeEvent {}

// Theme States
abstract class ThemeState {}

class LightTheme extends ThemeState {}

class DarkTheme extends ThemeState {}

// Theme BLoC
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(DarkTheme()) {
    on<ThemeToggled>(_onThemeToggled);
    on<ThemeInitialized>(_onThemeInitialized);
  }

  Future<void> _onThemeToggled(
    ThemeToggled event,
    Emitter<ThemeState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    if (state is LightTheme) {
      emit(DarkTheme());
      await prefs.setBool('isDarkMode', true);
    } else {
      emit(LightTheme());
      await prefs.setBool('isDarkMode', false);
    }
  }

  Future<void> _onThemeInitialized(
    ThemeInitialized event,
    Emitter<ThemeState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? true;

    if (isDarkMode) {
      emit(DarkTheme());
    } else {
      emit(LightTheme());
    }
  }
}
