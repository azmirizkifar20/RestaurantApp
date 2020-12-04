import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/api/result_state.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/providers/restaurant_provider.dart';
import 'package:restaurant_app/view/detail_page.dart';
import 'package:restaurant_app/view/favorite_page.dart';
import 'package:restaurant_app/view/search_page.dart';
import 'package:restaurant_app/view/setting_page.dart';
import 'package:restaurant_app/widget/card_restaurant.dart';

class ListPage extends StatefulWidget {
  static const routeName = '/list_page';

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  String avatar = 'assets/ajmi.png';
  String name = 'Muhamad Azmi Rizkifar';
  String email = 'm.azmirizkifar20@gmail.com';
  String banner =
      'https://t3.ftcdn.net/jpg/03/21/64/02/240_F_321640237_gHHFy6q0CbWCCVU2DUB7WEZbOpayWjl2.jpg';
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      backgroundColor: toscaColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_header(), _boxItems()],
        ),
      ),
      drawer: _drawer(),
    );
  }

  Container _header() => Container(
        margin: EdgeInsets.only(left: 16, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  child: Icon(Icons.dehaze, color: primaryColor),
                  onTap: () => _drawerKey.currentState.openDrawer(),
                ),
                Spacer(),
                Text(
                  'Dicoding Submissions',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'Oxygen',
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.search, color: primaryColor),
                  onPressed: () =>
                      Navigator.pushNamed(context, SearchPage.routeName),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'Restaurant',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontFamily: 'Oxygen',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
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
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                    child: Text(
                  value.message,
                  textAlign: TextAlign.center,
                )),
              );
              break;

            case ResultState.Error:
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                    child: Text(
                  value.message,
                  textAlign: TextAlign.center,
                )),
              );
              break;

            default:
              return Center(child: Text(''));
              break;
          }
        },
      );

  Drawer _drawer() => Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(name),
              accountEmail: Text(email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(avatar),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(banner),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            InkWell(
              child: ListTile(
                title: Text('Favorite restaurant'),
                subtitle: Text('See all your favorite restaurant'),
                trailing: Icon(Icons.favorite),
              ),
              onTap: () {
                Navigator.pop(context);
                return Navigator.pushNamed(context, FavoritePage.routeName);
              },
            ),
            Divider(),
            InkWell(
              child: ListTile(
                title: Text('Setting'),
                subtitle: Text('Application settings'),
                trailing: Icon(Icons.settings),
              ),
              onTap: () {
                Navigator.pop(context);
                return Navigator.pushNamed(context, SettingPage.routeName);
              },
            ),
            Divider(),
            InkWell(
              child: ListTile(
                trailing: Icon(Icons.close),
                title: Text('Close'),
              ),
              onTap: () => Navigator.pop(context),
            )
          ],
        ),
      );
}
