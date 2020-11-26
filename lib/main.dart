import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/styles.dart';
import 'package:restaurant_app/view/detail_page.dart';
import 'package:restaurant_app/view/list_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Apps',
      theme: ThemeData(
        primarySwatch: primaryColor,
        accentColor: secondaryColor,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: ListPage.routeName,
      routes: {
        ListPage.routeName: (context) => ListPage(),
        DetailPage.routeName: (context) => DetailPage(
              restaurant: ModalRoute.of(context).settings.arguments,
            )
      },
    );
  }
}
