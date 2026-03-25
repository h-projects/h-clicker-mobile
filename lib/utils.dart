import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HTheme {
  final Color color;
  final String name;
  final int price;

  HTheme(this.color, this.name, this.price);

  Color findDark() {
    return Color.from(
      alpha: 1,
      red: this.color.r / 1.5,
      green: this.color.g / 1.5,
      blue: this.color.b / 1.5,
    );
  }
}

class HThemes {
  HThemes._();

  static final _themes = [
    HTheme(Colors.blue, "Blue", 0),
    HTheme(Colors.teal, "Teal", 2500),
    HTheme(Colors.yellow, "Yellow", 4000),
    HTheme(Colors.deepOrange, "Dark orange", 5000),
    HTheme(Colors.purple, "Purple", 6000),
    HTheme(Colors.deepPurple, "Dark Purple", 7000),
    HTheme(Colors.pink, "Pink", 10000),
    HTheme(Colors.red, "Red", 15000),
    HTheme(Colors.green, "Lime", 20000),
    HTheme(Colors.white, "White", 50000),
  ];

  static final defaultTheme = _themes[0];

  static HTheme getTheme(int index) {
    try {
      return _themes[index];
    } catch (e) {
      throw FlutterError("Tried to get out of bounds index!");
    }
  }

  static Map<int, HTheme> themesMap() {
    return _themes.asMap();
  }
}

// TODO; document
// Keeps the global state - and synchronizes it with shared preferences on update
class HState {
  final ValueNotifier<int> counter;
  final ValueNotifier<int> themeIndex;
  final ValueNotifier<List<String>> ownedThemes;

  HState.fromValuesWithPrefs({
    required int counter,
    required int themeIndex,
    required List<String> ownedThemes,
    required SharedPreferencesWithCache sharedPrefs,
  }) : counter = ValueNotifier(counter),
       themeIndex = ValueNotifier(themeIndex),
       ownedThemes = ValueNotifier(ownedThemes) {
    this.counter.addListener(
      () => sharedPrefs.setInt(SharedPrefs.COUNTER, this.counter.value),
    );
    this.themeIndex.addListener(
      () => sharedPrefs.setInt(
        SharedPrefs.SELECTED_THEME_INDEX,
        this.themeIndex.value,
      ),
    );
    this.ownedThemes.addListener(
      () => sharedPrefs.setStringList(
        SharedPrefs.OWNED_THEMES,
        this.ownedThemes.value,
      ),
    );
  }
}

class SharedPrefs {
  static const COUNTER = "counter";
  static const SELECTED_THEME_INDEX = "selected_theme_index";
  static const OWNED_THEMES = "owned_themes";
}
