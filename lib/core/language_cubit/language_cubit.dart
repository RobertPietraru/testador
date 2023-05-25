import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  late final SharedPreferences sharedPreferences;
  LanguageCubit() : super(LanguageState(locale: Platform.localeName)) {
    init();
  }
  Future<void> update(String newLocale) async {
    sharedPreferences.setString("locale", newLocale);
    emit(LanguageState(locale: newLocale));
  }

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final locale = sharedPreferences.getString("locale");
    if (locale == null) {
      sharedPreferences.setString("locale", Platform.localeName);
      emit(LanguageState(locale: Platform.localeName));
    } else {
      emit(LanguageState(locale: locale));
    }
  }
}
