import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/api/result_state.dart';
import 'package:restaurant_app/utils/providers/restaurant_provider.dart';
import 'package:restaurant_app/utils/style/styles.dart';
import 'package:restaurant_app/view/detail_page.dart';
import 'package:restaurant_app/view/search_page.dart';
import 'package:restaurant_app/widget/card_restaurant.dart';

class ListPage extends StatefulWidget {
  static const routeName = '/list_page';

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: toscaColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_header(), _boxItems()],
        ),
      ),
    );
  }

  Container _header() => Container(
        margin: EdgeInsets.only(top: 12, left: 24, right: 16),
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

  Expanded _boxItems() => Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(75.0)),
          ),
          child: ChangeNotifierProvider<RestaurantProvider>(
            create: (_) => RestaurantProvider(apiService: ApiService()),
            child: _consumer(),
          ),
        ),
      );

  Consumer<RestaurantProvider> _consumer() => Consumer(
        builder: (context, value, _) {
          switch (value.state) {
            case ResultState.Loading:
              return Center(child: CircularProgressIndicator());
              break;

            case ResultState.HasData:
              return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 8),
                itemCount: value.result.count,
                itemBuilder: (context, index) {
                  var restaurant = value.result.restaurants[index];
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
              break;

            case ResultState.NoData:
              return Center(child: Text(value.message));
              break;

            case ResultState.Error:
              return Center(child: Text(value.message));
              break;

            default:
              return Center(child: Text(''));
              break;
          }
        },
      );
}
