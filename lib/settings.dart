import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          color: Colors.white,
          tiles: [
            ListTile(
              title: Text("Settings coming soon!"),
            ),
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Credits",
                          style: Theme.of(context).textTheme.headline,
                        ),
                        Divider(
                          color: Colors.white,
                          endIndent: 350,
                        ),
                        Text(
                          "Made by dnorhoj"
                        ),
                        Text(
                          "A lot of ideas from the H discord server"
                        ),
                      ],
                    )
                  ),
                  Text(
                    "Special thanks to",
                    style: Theme.of(context).textTheme.headline,
                  ),
                  Divider(
                    color: Colors.white,
                    endIndent: 350,
                  ),
                  Text(
                    " - u/spacexfan100 for the idea"
                  ),
                  Text(
                    " - You for playing"
                  )
                ],
              ),
            ),
          ],
        ).toList()
      ),
    );
  }
}