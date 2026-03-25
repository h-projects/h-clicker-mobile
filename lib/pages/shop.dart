import 'package:flutter/material.dart';
import '../utils.dart';

class ShopPage extends StatefulWidget {
  final HState state;

  const ShopPage(this.state, {super.key});

  @override
  _ShopPageState createState() => _ShopPageState(this.state);
}

class _ShopPageState extends State<ShopPage> {
  final HState _state;

  _ShopPageState(this._state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shop")),
      body: ListView(
        children: ListTile.divideTiles(
          color: Colors.white,
          tiles: HThemes.themesMap().entries.map((theme) {
            return GestureDetector(
              child: ListTile(
                leading: Text("H", style: TextStyle(color: theme.value.color)),
                title: Text(theme.value.name),
                trailing: ValueListenableBuilder(
                  valueListenable: this._state.themeIndex,
                  builder: (context, themeIndex, widget) =>
                      ValueListenableBuilder(
                        valueListenable: this._state.counter,
                        builder: (context, counter, widget) =>
                            this._state.ownedThemes.value.contains(
                              theme.key.toString(),
                            )
                            ? themeIndex == theme.key
                                  ? Text(
                                      "Selected",
                                      style: TextStyle(color: Colors.green),
                                    )
                                  : Text(
                                      "Owned",
                                      style: TextStyle(color: Colors.orange),
                                    )
                            : Text(
                                "${theme.value.price} H's",
                                style: TextStyle(
                                  color: theme.value.price > (counter)
                                      ? Colors.red
                                      : Colors.white,
                                ),
                              ),
                      ),
                ),
              ),
              onTap: () {
                if (this._state.ownedThemes.value.contains(
                  theme.key.toString(),
                )) {
                  this._state.themeIndex.value = theme.key;
                } else if (this._state.counter.value >= theme.value.price) {
                  this._state.counter.value -= theme.value.price;
                  this._state.ownedThemes.value = [
                    ...this._state.ownedThemes.value,
                    theme.key.toString(),
                  ];
                  this._state.themeIndex.value = theme.key;
                }
              },
            );
          }),
        ).toList(),
      ),
    );
  }
}
