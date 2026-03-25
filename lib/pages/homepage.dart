import 'package:flutter/material.dart';
import 'package:h_clicker/pages/settings.dart';
import 'package:h_clicker/pages/shop.dart';
import 'package:h_clicker/utils.dart';

class HPage extends StatefulWidget {
  final HState state;

  const HPage(this.state, {super.key});

  @override
  _HPageState createState() => _HPageState(state);
}

class _HPageState extends State<HPage> {
  final HState _state;

  bool _pressed = false;

  _HPageState(this._state);

  void unPress([_]) {
    setState(() {
      _pressed = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100),
            child: Center(
              child: ValueListenableBuilder(
                valueListenable: this._state.counter,
                builder: (context, counter, widget) => Column(
                  children: [
                    Text("H's clicked:", style: TextStyle(fontSize: 20)),
                    Text(counter.toString(), style: TextStyle(fontSize: 50)),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              child: ValueListenableBuilder(
                valueListenable: this._state.themeIndex,
                builder: (context, themeIndex, widget) => Text(
                  "H",
                  style: TextStyle(
                    fontSize: 200,
                    color: _pressed
                        ? HThemes.getTheme(themeIndex).findDark()
                        : HThemes.getTheme(themeIndex).color,
                  ),
                ),
              ),
              onTapDown: (_) {
                setState(() {
                  _pressed = true;
                });

                this._state.counter.value++;
              },
              onTapUp: unPress,
              onTapCancel: unPress,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: ValueListenableBuilder(
                valueListenable: this._state.themeIndex,
                builder: (context, themeIndex, widget) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                      [
                        (Icons.settings, (context) => SettingsPage()),
                        (Icons.store, (context) => ShopPage(this._state)),
                      ].map((route) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: route.$2),
                            );
                          },
                          child: Icon(
                            route.$1,
                            color: HThemes.getTheme(themeIndex).color,
                            size: 60,
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
