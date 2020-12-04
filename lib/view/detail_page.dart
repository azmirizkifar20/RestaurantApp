import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/api/result_state.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_favorite.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/providers/database_provider.dart';
import 'package:restaurant_app/providers/restaurant_detail_provider.dart';
import 'package:restaurant_app/view/review_page.dart';
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
  final provider = RestaurantDetailProvider(apiService: ApiService());
  final dbProvider = DatabaseProvider(databaseHelper: DatabaseHelper());
  static const _imageUrl = 'https://restaurant-api.dicoding.dev/images/medium';

  @override
  void initState() {
    provider.fetchDetailRestaurant(widget.id);
    dbProvider.isFavorited(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => provider,
      child: Scaffold(
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, value, _) {
            switch (value.state) {
              case ResultState.Loading:
                return Center(child: CircularProgressIndicator());
                break;

              case ResultState.HasData:
                return ChangeNotifierProvider<DatabaseProvider>.value(
                  value: dbProvider,
                  child: Consumer<DatabaseProvider>(
                    builder: (context, dbValue, _) => NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) {
                        if (innerBoxIsScrolled) {
                          return [
                            SliverAppBar(
                              pinned: true,
                              expandedHeight: 220,
                              flexibleSpace: FlexibleSpaceBar(
                                background: Hero(
                                  tag: value.result.restaurant.pictureId,
                                  child: Image.network(
                                    '$_imageUrl/${value.result.restaurant.pictureId}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(value.result.restaurant.name),
                                titlePadding:
                                    EdgeInsets.only(left: 54, bottom: 16),
                              ),
                              actions: [
                                _favoriteButton(value.result.restaurant),
                              ],
                            ),
                          ];
                        } else {
                          return [
                            SliverAppBar(
                              pinned: true,
                              expandedHeight: 220,
                              flexibleSpace: FlexibleSpaceBar(
                                background: Hero(
                                  tag: value.result.restaurant.pictureId,
                                  child: Image.network(
                                    '$_imageUrl/${value.result.restaurant.pictureId}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              actions: [
                                _favoriteButton(value.result.restaurant),
                              ],
                            )
                          ];
                        }
                      },
                      body: Container(
                        transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                        child: _content(context, value.result.restaurant),
                      ),
                    ),
                  ),
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
        ),
      ),
    );
  }

  void _addFavorite(Restaurant data) {
    Favorite favorite = Favorite(
      id: data.id,
      name: data.name,
      description: data.description,
      city: data.city,
      address: data.address,
      pictureId: data.pictureId,
      rating: data.rating,
    );
    dbProvider.addFavorite(favorite);
  }

  FutureBuilder _favoriteButton(Restaurant restaurant) => FutureBuilder<bool>(
        future: dbProvider.isFavorited(widget.id),
        builder: (context, snapshot) {
          var isFavorited = snapshot.data ?? false;

          if (isFavorited) {
            return Padding(
              padding: EdgeInsets.only(right: 8),
              child: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: primaryColor,
                ),
                onPressed: () => dbProvider.removeFavorite(widget.id),
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.only(right: 8),
              child: IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: primaryColor,
                ),
                onPressed: () => _addFavorite(restaurant),
              ),
            );
          }
        },
      );

  Padding _content(BuildContext context, Restaurant restaurant) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
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

                // review
                Row(
                  children: [
                    Text(
                      'Review customer',
                      style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.more_horiz,
                        color: Colors.grey[600],
                        size: 30.0,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          ReviewPage.routeName,
                          arguments: restaurant.id,
                        );
                      },
                    ),
                  ],
                ),
                CardReview(listReview: restaurant.customerReviews, itemSize: 2),
              ],
            ),
          ),
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
