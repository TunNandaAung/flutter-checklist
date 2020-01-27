import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:checklist/preferences/preferences.dart';
import 'package:checklist/theme/app_theme.dart';
import 'package:checklist/theme/bloc/theme_barrel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvent, AppTheme> {
  @override
  AppTheme get initialState => AppTheme.values[Prefer.themeIndexPref];

  @override
  Stream<AppTheme> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChanged) {
      yield event.theme;
      Prefer.prefs = await SharedPreferences.getInstance();
      Prefer.prefs.setInt('theme', event.theme.index);
      Prefer.themeIndexPref = event.theme.index;
      print('App Theme: ${event.theme}');
    }
  }
}
