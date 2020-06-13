import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int _selected = 0;
  List<String> _owned = ["0"];

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then(updateState);
  }

  void updateState(SharedPreferences prefs) {
    setState(() {
      _selected = prefs.getInt("selected_h") ?? _selected;
      _owned = prefs.getStringList("owned_h") ?? _owned;
    });
  }

  @override
  Widget build(BuildContext context) {
    final StateArgs args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Shop"),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          color: Colors.white,
          tiles: HColors.shopColors.map((m) {
            final i = HColors.shopColors.indexOf(m);
            return GestureDetector(
              child: ListTile(
                leading: Text(
                  "H",
                  style: TextStyle(color: m[0], fontSize: 50),
                ),
                title: Text(m[1]),
                trailing: _owned.contains(i.toString())
                  ? _selected == i
                  ? Text("Selected", style: TextStyle(color: Colors.green))
                  : Text("Owned", style: TextStyle(color: Colors.orange))
                  : Text(
                    "${m[2]} H's",
                    style: TextStyle(
                      color: (m[2] as int)>(args.counter.value)
                      ? Colors.red
                      : Colors.white
                    )
                  ),
              ),
              onTap: () {
                if(_owned.contains(i.toString())) {
                  setState(() {
                    _selected = i;
                    args.color.value = HColors.shopColors[_selected][0];
                  });
                  SharedPreferences.getInstance().then((prefs) {
                    prefs.setInt("selected_h", i);
                  });
                } else {
                  SharedPreferences.getInstance().then((prefs) {
                    if(args.counter.value >= m[2]) {
                      args.counter.value -= m[2];
                      prefs.setInt("selected_h", i);
                      prefs.setStringList("owned_h", _owned..add(i.toString()));
                      updateState(prefs);
                    }
                  });
                }
              },
            );
          })
        ).toList()
      ),
    );
  }
}
