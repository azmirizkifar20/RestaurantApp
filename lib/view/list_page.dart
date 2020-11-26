import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/styles.dart';
import 'package:restaurant_app/view/detail_page.dart';

class ListPage extends StatelessWidget {
  static const routeName = '/list_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: toscaColor,
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_header(), _boxItems(context)],
          ),
        ),
      ),
    );
  }

  Container _header() => Container(
        margin: EdgeInsets.only(top: 24, left: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            future: DefaultAssetBundle.of(context)
                .loadString('assets/restaurant.json'),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(child: Text("Sedang memuat data..."));
              }

              List<Restaurant> listData = parseRestaurant(snapshot.data);
              return listData.isEmpty
                  ? Center(child: Text("Data kosong:("))
                  : ListView.builder(
                      padding: EdgeInsets.only(top: 8),
                      itemCount: listData.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Navigator.pushNamed(
                            context,
                            DetailPage.routeName,
                            arguments: listData[index],
                          ),
                          child: _listItems(listData[index]),
                        );
                      },
                    );
            },
          ),
        ),
      );

  Widget _listItems(Restaurant restaurant) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Hero(
            tag: restaurant.pictureId,
            child: Material(
              child: InkWell(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    restaurant.pictureId,
                    width: 120,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: darkColor,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: Colors.black45,
                      size: 14,
                    ),
                    SizedBox(width: 4),
                    Text(restaurant.city)
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.black,
                      size: 14,
                    ),
                    SizedBox(width: 4),
                    Text(restaurant.rating.toString())
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
