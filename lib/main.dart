import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:restaurant_app/view/detail_page.dart';
import 'package:restaurant_app/view/favorite_page.dart';
import 'package:restaurant_app/view/list_page.dart';
import 'package:restaurant_app/view/profile_page.dart';
import 'package:restaurant_app/view/review_page.dart';
import 'package:restaurant_app/view/search_page.dart';
import 'package:restaurant_app/view/setting_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Apps',
      theme: ThemeData(
        primaryColor: toscaColor,
        accentColor: secondaryColor,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: ListPage.routeName,
      routes: {
        ListPage.routeName: (context) => ListPage(),
        SearchPage.routeName: (context) => SearchPage(),
        SettingPage.routeName: (context) => SettingPage(),
        FavoritePage.routeName: (context) => FavoritePage(),
        DetailPage.routeName: (context) => DetailPage(
              id: ModalRoute.of(context).settings.arguments,
            ),
        ReviewPage.routeName: (context) => ReviewPage(
              restaurantId: ModalRoute.of(context).settings.arguments,
            ),
        ProfilePage.routeName: (context) => ProfilePage(
              gambar: ModalRoute.of(context).settings.arguments,
            )
      },
      navigatorKey: navigatorKey,
    );
  }
}
