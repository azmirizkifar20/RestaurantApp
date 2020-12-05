import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/providers/SchedulingProvider.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';

class SettingPage extends StatelessWidget {
  static const routeName = '/setting_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: toscaColor,
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<SchedulingProvider>(
        create: (_) => SchedulingProvider(
          preferencesHelper: PreferencesHelper(
            sharedPreferences: SharedPreferences.getInstance(),
          ),
        ),
        child: ListView(
          children: [
            Consumer<SchedulingProvider>(
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
                  trailing: Switch.adaptive(
                    value: provider.isScheduled,
                    onChanged: (value) async {
                      provider.scheduledRestaurant(value);
                    },
                    activeTrackColor: materialToscaColor[100],
                    activeColor: toscaColor,
                  ),
                );
              },
            ),
            Divider(),
            InkWell(
              onTap: () => _showDialog(context),
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

  void _showDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Perhatian"),
          content: Text('Yakin ingin keluar aplikasi?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Tidak",
                style: TextStyle(color: darkColor),
              ),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text(
                "Ya",
                style: TextStyle(color: darkColor),
              ),
            ),
          ],
        ),
      );
}
