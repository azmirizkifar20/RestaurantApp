import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/api/result_state.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/utils/style/styles.dart';
import 'package:restaurant_app/widget/card_category.dart';
import 'package:restaurant_app/widget/card_menu.dart';
import 'package:restaurant_app/widget/card_review.dart';
import 'package:restaurant_app/utils/providers/restaurant_detail_provider.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_page';

  final String id;
  DetailPage({@required this.id});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final provider = RestaurantDetailProvider(apiService: ApiService());
  static const _imageUrl = 'https://restaurant-api.dicoding.dev/images/medium';

  @override
  void initState() {
    provider.fetchDetailRestaurant(widget.id);
    super.initState();
  }

  void _addReview(Map data) {
    provider.addReview(data);
    provider.fetchDetailRestaurant(widget.id);
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
                return NestedScrollView(
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
                            titlePadding: EdgeInsets.only(left: 54, bottom: 16),
                          ),
                        )
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
                        )
                      ];
                    }
                  },
                  body: Container(
                    transform: Matrix4.translationValues(0.0, -16.0, 0.0),
                    child: _content(context, value.result.restaurant),
                  ),
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
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Add review",
          backgroundColor: toscaColor,
          child: Icon(Icons.edit, color: primaryColor),
          onPressed: () => showFormDialog(context),
        ),
      ),
    );
  }

  Padding _content(BuildContext context, Restaurant restaurant) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 8),
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
                      onPressed: () {},
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

  Future<void> showFormDialog(BuildContext context) async => await showDialog(
      context: context,
      builder: (context) {
        final TextEditingController _namaController = TextEditingController();
        final TextEditingController _reviewController = TextEditingController();

        return AlertDialog(
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Tambah review',
                  style: TextStyle(fontSize: 20, color: darkColor),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    return value.isNotEmpty ? null : "Nama wajib diisi";
                  },
                  controller: _namaController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    labelText: 'Masukkan nama',
                    hintStyle: TextStyle(color: darkColor),
                    labelStyle: TextStyle(color: darkColor),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  validator: (value) {
                    return value.isNotEmpty ? null : "Invalid field";
                  },
                  minLines: 3,
                  maxLines: 5,
                  controller: _reviewController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    labelText: 'Masukkan review',
                    hintStyle: TextStyle(color: darkColor),
                    labelStyle: TextStyle(color: darkColor),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: darkColor),
              ),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _addReview({
                    'id': widget.id,
                    'name': _namaController.text,
                    'review': _reviewController.text
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                "Save",
                style: TextStyle(color: darkColor),
              ),
            ),
          ],
        );
      });
}
