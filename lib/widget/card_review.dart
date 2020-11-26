import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/utils/style/styles.dart';

class CardReview extends StatelessWidget {
  final List<CustomerReview> listReview;

  const CardReview({Key key, @required this.listReview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listReview.length,
        itemBuilder: (context, index) {
          return _itemReview(listReview[index]);
        },
      ),
    );
  }

  Widget _itemReview(CustomerReview review) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              review.name,
              style: TextStyle(fontSize: 18, color: darkColor),
            ),
            SizedBox(height: 2),
            Text(
              review.date,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              review.review,
              style: TextStyle(fontSize: 16, color: darkColor),
            ),
          ],
        ),
      ),
    );
  }
}
