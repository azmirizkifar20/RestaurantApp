import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/styles.dart';
import 'package:restaurant_app/view/detail_page.dart';
import 'package:restaurant_app/view/search_page.dart';
import 'package:restaurant_app/widget/card_restaurant.dart';

class ListPage extends StatefulWidget {
  static const routeName = '/list_page';

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future<RestaurantResult> _restaurant;

  @override
  void initState() {
    _restaurant = ApiService().listRestaurant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: toscaColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_header(), _boxItems(context)],
        ),
      ),
    );
  }

  Container _header() => Container(
        margin: EdgeInsets.only(top: 24, left: 24, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Restaurant',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 26,
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, SearchPage.routeName),
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(
              'Recomended restaurant for you!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white60,
                fontFamily: 'Oxygen',
              ),
            )
          ],
        ),
      );

  Expanded _boxItems(BuildContext context) => Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(75.0)),
          ),
          child: FutureBuilder(
            future: _restaurant,
            builder: (context, AsyncSnapshot<RestaurantResult> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 8),
                    itemCount: snapshot.data.count,
                    itemBuilder: (context, index) {
                      var restaurant = snapshot.data.restaurants[index];
                      return InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          DetailPage.routeName,
                          arguments: restaurant.id,
                        ),
                        child: CardRestaurant(restaurant: restaurant),
                      );
                    },
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
      );
}
