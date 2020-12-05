import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/add_review.dart';
import 'package:restaurant_app/common/styles.dart';

class CardReview extends StatelessWidget {
  final List<CustomerReview> listReview;
  final int itemSize;

  const CardReview({Key key, @required this.listReview, this.itemSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: itemSize == null ? listReview.length : itemSize,
        itemBuilder: (context, index) {
          return _itemReview(listReview[index]);
        },
      ),
    );
  }

  Card _itemReview(CustomerReview review) => Card(
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
