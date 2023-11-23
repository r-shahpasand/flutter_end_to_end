
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonProvider with ChangeNotifier {

  ThemeMode themeModeType = ThemeMode.system;
  Locale? selectedLocale = AppLocalizations.supportedLocales.firstOrNull;

  void onChangeOfTheme() {
    themeModeType = isLightTheme ?  ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void onChangeOfLanguage(Locale? locale) {
    if(locale != null) {
      selectedLocale = locale;
      notifyListeners();
    }
  }

  bool get isLightTheme => themeModeType == ThemeMode.light || themeModeType == ThemeMode.system;

}