import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/widget/card_category.dart';
import 'package:restaurant_app/widget/card_menu.dart';
import 'package:restaurant_app/widget/card_review.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_page';

  final String id;
  DetailPage({@required this.id});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<RestaurantDetailResult> _restaurant;
  static const _imageUrl = 'https://restaurant-api.dicoding.dev/images/medium';

  @override
  void initState() {
    _restaurant = ApiService().detailRestaurant(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: FutureBuilder(
            future: _restaurant,
            builder: (context, AsyncSnapshot<RestaurantDetailResult> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _header(context, snapshot.data.restaurant),
                      SizedBox(height: 8),
                      _content(context, snapshot.data.restaurant),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return Center(child: Text("Data kosong:("));
                }
              }
            },
          ),
        ),
      ),
    );
  }

  Stack _header(BuildContext context, Restaurant restaurant) => Stack(
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
                  child: Image.network('$_imageUrl/${restaurant.pictureId}'),
                ),
              ),
            ),
          ),
          // back button
          InkWell(
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
          )
        ],
      );

  Padding _content(BuildContext context, Restaurant restaurant) => Padding(
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
                  restaurant.address,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Spacer(),
                Row(
                  children: _rating(restaurant.rating),
                )
              ],
            ),
            SizedBox(height: 10),
            CardCategory(listData: restaurant.categories),

            // pembatas
            SizedBox(height: 5),
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
            CardMenu(listData: restaurant.menus.foods),

            // pembatas
            SizedBox(height: 15),

            // menu foods
            Text(
              'Menu minuman',
              style: TextStyle(fontSize: 20, color: Colors.grey[600]),
            ),
            SizedBox(height: 6),
            CardMenu(listData: restaurant.menus.drinks),

            // pembatas
            SizedBox(height: 10),
            Divider(color: Colors.grey),
            SizedBox(height: 10),

            // review
            Text(
              'Review customer',
              style: TextStyle(fontSize: 20, color: Colors.grey[600]),
            ),
            SizedBox(height: 6),
            CardReview(listReview: restaurant.customerReviews)
          ],
        ),
      );

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
}
