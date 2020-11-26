import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/styles.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';

  final Restaurant restaurant;
  DetailPage({@required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context),
            SizedBox(height: 8),
            _content(context),
          ],
        ),
      ),
    );
  }

  Stack _header(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: restaurant.pictureId,
          child: Material(
            child: InkWell(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                child: Image.network(restaurant.pictureId),
              ),
            ),
          ),
        ),
        // back button
        SafeArea(
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(top: 8, left: 8),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.black87,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  List<Widget> _rating(double rating) {
    final children = <Widget>[];
    for (var i = 0; i < rating; i++) {
      children.add(Icon(
        Icons.star,
        color: Colors.yellow[600],
        size: 20,
      ));
    }

    return children;
  }

  Widget _content(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.name,
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Icon(
                Icons.location_pin,
                color: Colors.grey[400],
                size: 18,
              ),
              SizedBox(width: 4),
              Text(
                restaurant.city,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Spacer(),
              Row(
                children: _rating(restaurant.rating),
              )
            ],
          ),

          // pembatas
          SizedBox(height: 10),
          Divider(color: Colors.grey),
          SizedBox(height: 10),
          Text(
            'Deskripsi',
            style: TextStyle(fontSize: 20, color: Colors.grey[600]),
          ),
          SizedBox(height: 6),
          Text(
            restaurant.description,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),

          // pembatas
          SizedBox(height: 10),
          Divider(color: Colors.grey),
          SizedBox(height: 10),

          // menu foods
          Text(
            'Menu makanan',
            style: TextStyle(fontSize: 20, color: Colors.grey[600]),
          ),
          SizedBox(height: 6),
          _listBuilder(restaurant.menus.foods),

          // pembatas
          SizedBox(height: 15),

          // menu foods
          Text(
            'Menu minuman',
            style: TextStyle(fontSize: 20, color: Colors.grey[600]),
          ),
          SizedBox(height: 6),
          _listBuilder(restaurant.menus.drinks),
        ],
      ),
    );
  }

  Widget _listBuilder(List<Menu> listData) {
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

  Widget _itemMenus(String menu) {
    return Container(
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
}
