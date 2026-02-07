import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageState(languageCode: 'ar')) {
    _getSavedLanguage();
  }

  Future<void> _getSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLangCode = prefs.getString('langCode') ?? 'ar';
    emit(LanguageState(languageCode: savedLangCode));
  }

  Future<void> changeLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('langCode', langCode);
    emit(LanguageState(languageCode: langCode));
  }


  bool isArabic() {
    return state.languageCode == 'ar';
  }
}
