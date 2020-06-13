import 'package:flutter/material.dart';

class HColors {
  static final shopColors = [
    [Colors.blue, "Blue", 0],
    [Colors.teal, "Teal", 2500],
    [Colors.yellow, "Yellow", 4000],
    [Colors.deepOrange, "Dark orange", 5000],
    [Colors.purple, "Purple", 6000],
    [Colors.deepPurple, "Dark Purple", 7000],
    [Colors.pink, "Pink", 10000],
    [Colors.red, "Red", 15000],
    [Colors.green, "Lime", 20000],
    [Colors.white, "White", 50000],
  ];

  static Color findDark(Color color) {
    return Color.fromARGB(
      255,
      (color.red/1.5).round(),
      (color.green/1.5).round(),
      (color.blue/1.5).round()
    );
  }
}

class StateArgs {
  final ValueNotifier counter;
  final ValueNotifier color;

  StateArgs(this.counter, this.color);
}