import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';
import 'package:restaurant_app/providers/preferences_provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  static const routeName = '/setting_page';

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: toscaColor,
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (_) => PreferencesProvider(
          preferencesHelper: PreferencesHelper(
            sharedPreferences: SharedPreferences.getInstance(),
          ),
        ),
        child: ListView(
          children: [
            Consumer<PreferencesProvider>(
              builder: (context, provider, _) {
                return ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8),
                    child: Icon(
                      Icons.notifications,
                      color: toscaColor,
                    ),
                  ),
                  title: Text('Restaurant notification'),
                  subtitle: Text('Notify me at 11 A.M'),
                  trailing: Switch(
                    value: provider.isNotificationActive,
                    onChanged: (value) => provider.setNotificationStatus(value),
                    activeTrackColor: materialToscaColor[100],
                    activeColor: toscaColor,
                  ),
                );
              },
            ),
            Divider(),
            InkWell(
              onTap: () => SystemNavigator.pop(),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.exit_to_app,
                    color: toscaColor,
                  ),
                ),
                title: Text('Exit application'),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
