import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/common/styles.dart';

class CardMenu extends StatelessWidget {
  final List<Category> listData;

  const CardMenu({Key key, @required this.listData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: listData.length,
        itemBuilder: (context, index) {
          return _itemMenus(listData[index].name);
        },
      ),
    );
  }

  Container _itemMenus(String menu) => Container(
        width: 100,
        child: Card(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                menu,
                style: TextStyle(color: darkColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
}
