import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/result_state.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/utils/providers/database_provider.dart';
import 'package:restaurant_app/utils/style/styles.dart';
import 'package:restaurant_app/view/detail_page.dart';
import 'package:restaurant_app/widget/card_favorite.dart';

class FavoritePage extends StatefulWidget {
  static const routeName = '/favorite_page';

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final provider = DatabaseProvider(databaseHelper: DatabaseHelper());

  @override
  void initState() {
    provider.getFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DatabaseProvider>(
      create: (_) => provider,
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: toscaColor,
          title: Text("Favorite restaurant"),
          centerTitle: true,
        ),
        body: Consumer<DatabaseProvider>(
          builder: (context, value, _) {
            switch (value.state) {
              case ResultState.Loading:
                return Center(child: CircularProgressIndicator());
                break;

              case ResultState.NoData:
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      value.message,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
                break;

              case ResultState.HasData:
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.favorites.length,
                    itemBuilder: (context, index) {
                      var restaurant = value.favorites[index];
                      return InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          DetailPage.routeName,
                          arguments: restaurant.id,
                        ),
                        child: Dismissible(
                          key: Key(restaurant.id),
                          background: Container(
                            color: Colors.blueGrey[50],
                          ),
                          onDismissed: (_) =>
                              provider.removeFavorite(restaurant.id),
                          child: CardFavorite(restaurant: restaurant),
                        ),
                      );
                    },
                  ),
                );
                break;

              case ResultState.Error:
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      value.message,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
                break;

              default:
                return Center(child: Text(''));
                break;
            }
          },
        ),
      ),
    );
  }
}
