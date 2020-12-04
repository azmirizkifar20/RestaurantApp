import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/style/styles.dart';
import 'package:restaurant_app/view/detail_page.dart';
import 'package:restaurant_app/view/favorite_page.dart';
import 'package:restaurant_app/view/list_page.dart';
import 'package:restaurant_app/view/review_page.dart';
import 'package:restaurant_app/view/search_page.dart';
import 'package:restaurant_app/view/setting_page.dart';

void main() {
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
            )
      },
    );
  }
}
