import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/style/styles.dart';

class SettingPage extends StatefulWidget {
  static const routeName = '/setting_page';

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: toscaColor,
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: Icon(
                Icons.notifications,
                color: toscaColor,
              ),
            ),
            title: Text('Restaurant notification'),
            subtitle: Text('Notification enabled'),
            trailing: Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
              activeTrackColor: materialToscaColor[100],
              activeColor: toscaColor,
            ),
          )
        ],
      ),
    );
  }
}
