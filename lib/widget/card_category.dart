import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/common/styles.dart';

class CardCategory extends StatelessWidget {
  final List<Category> listData;

  const CardCategory({Key key, @required this.listData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
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

  Padding _itemMenus(String menu) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              menu,
              style: TextStyle(color: darkColor, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}
