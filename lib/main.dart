import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:h_clicker/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/homepage.dart';

HState build_state(SharedPreferencesWithCache sharedPrefs) {
  var counter = sharedPrefs.getInt(SharedPrefs.COUNTER) ?? 0;
  var themeIndex = sharedPrefs.getInt(SharedPrefs.SELECTED_THEME_INDEX) ?? 0;
  var ownedThemes =
      sharedPrefs.getStringList(SharedPrefs.OWNED_THEMES) ?? ["0"];

  return HState.fromValuesWithPrefs(
    counter: counter,
    themeIndex: themeIndex,
    ownedThemes: ownedThemes,
    sharedPrefs: sharedPrefs,
  );
}

void main() async {
  var sharedPrefs = await SharedPreferencesWithCache.create(
    cacheOptions: SharedPreferencesWithCacheOptions(),
  );

  runApp(HClicker(build_state(sharedPrefs)));
}

class HClicker extends StatelessWidget {
  final HState state;

  const HClicker(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'H Clicker',
      theme: ThemeData(
        brightness: Brightness.dark,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder()},
        ),
      ),
      home: HPage(state),
    );
  }
}
