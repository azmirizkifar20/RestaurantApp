import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_favorite.dart';
import 'package:restaurant_app/common/styles.dart';

class CardFavorite extends StatelessWidget {
  final Favorite restaurant;
  static const _imageUrl = 'https://restaurant-api.dicoding.dev/images/small';

  const CardFavorite({Key key, @required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                Text(
                  restaurant.city ?? "",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow[600],
                  size: 14,
                ),
                SizedBox(width: 4),
                Text(
                  restaurant.rating.toString() ?? "",
                  style: TextStyle(fontWeight: FontWeight.w500),
                )
              ],
            ),
          ],
        ),
      );
}
