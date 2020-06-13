import 'package:flutter/material.dart';
import 'package:h_clicker/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HPage extends StatefulWidget {
  @override
  _HPageState createState() => _HPageState();
}

class _HPageState extends State<HPage> {
  final _counter = ValueNotifier(0);
  bool _pressed = false;
  var _color = ValueNotifier(Colors.blue);

  void unPress([_]) {
    setState(() {
      _pressed = false;
    });
  }

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _counter.value = prefs.getInt("counter") ?? 0;
        _color.value = HColors.shopColors[prefs.getInt("selected_h")][0] ?? _color.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 100),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    "H's clicked:",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${_counter.value}",
                    style: TextStyle(
                      fontSize: 50,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              child: Text(
                "H",
                style: TextStyle(
                  fontSize: 200,
                  color: _pressed ? HColors.findDark(_color.value) : _color.value
                ),
              ),
              onTapDown: (_) {
                setState(() {
                  _counter.value++;
                  _pressed = true;
                });
                SharedPreferences.getInstance().then((prefs) {
                  prefs.setInt("counter", _counter.value);
                });
              },
              onTapUp: unPress,
              onTapCancel: unPress
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 50
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  [Icons.settings, "/settings"],
                  [Icons.store, "/shop"]
                ].map((m) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, m[1], arguments: StateArgs(_counter, _color));
                    },
                    child: Icon(
                      m[0],
                      color: _color.value,
                      size: 60,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
