import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile_page';

  final String gambar;
  ProfilePage({@required this.gambar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: toscaColor,
        title: Text("Muhamad Azmi Rizkifar"),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Hero(
            tag: gambar,
            child: Material(
                child: InkWell(
              child: Image.asset(gambar, fit: BoxFit.fill),
            )),
          ),
        ),
      ),
    );
  }
}
