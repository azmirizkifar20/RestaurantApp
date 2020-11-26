import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/style/styles.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  static const _imageUrl = 'https://restaurant-api.dicoding.dev/images/small';

  const CardRestaurant({Key key, @required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    "$_imageUrl/${restaurant.pictureId}",
                    width: 120,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          _flexBox(),
        ],
      ),
    );
  }

  Flexible _flexBox() => Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restaurant.name ?? "",
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
                Text(restaurant.city ?? "")
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
                Text(restaurant.rating.toString() ?? "")
              ],
            ),
          ],
        ),
      );
}
