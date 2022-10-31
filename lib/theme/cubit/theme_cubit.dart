import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:checklist/preferences/preferences.dart';
import 'package:checklist/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<AppTheme> {
  ThemeCubit() : super(AppTheme.values[Prefer.themeIndexPref]);

  Future<void> changeTheme(AppTheme theme) async {
    Prefer.prefs = await SharedPreferences.getInstance();
    Prefer.prefs.setInt('theme', theme.index);
    emit(theme);
  }
}
