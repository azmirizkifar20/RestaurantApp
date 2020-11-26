import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';
import 'package:restaurant_app/utils/styles.dart';
import 'package:restaurant_app/view/detail_page.dart';
import 'package:restaurant_app/widget/card_search.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<RestaurantSearchResult> _restaurant;
  var _searchEdit = new TextEditingController();
  String _searchText = "";

  @override
  void initState() {
    _restaurant = ApiService().searchRestaurant(_searchText);
    super.initState();
  }

  _SearchPageState() {
    _searchEdit.addListener(() {
      setState(() {
        _searchText = _searchEdit.text;
        _restaurant = ApiService().searchRestaurant(_searchText);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: toscaColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 28,
                    color: primaryColor,
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _searchView(),
              _boxItem(context)
            ],
          ),
        ),
      ),
    );
  }

  Padding _searchView() => Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: _searchEdit,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(100),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(100),
            ),
            hintText: 'Search restaurant',
            labelText: 'Restaurant',
            hintStyle: TextStyle(color: primaryColor),
            labelStyle: TextStyle(color: primaryColor),
          ),
          style: TextStyle(color: primaryColor),
        ),
      );

  Expanded _boxItem(BuildContext context) => Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 8),
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                topLeft: Radius.circular(30.0)),
          ),
          child: FutureBuilder(
            future: _restaurant,
            builder: (context, AsyncSnapshot<RestaurantSearchResult> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasData) {
                  if (snapshot.data.founded == 0) {
                    return Center(child: Text("Cari data restaurant"));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 8),
                      itemCount: snapshot.data.founded,
                      itemBuilder: (context, index) {
                        var restaurant = snapshot.data.restaurants[index];
                        return InkWell(
                          onTap: () => Navigator.pushNamed(
                            context,
                            DetailPage.routeName,
                            arguments: restaurant.id,
                          ),
                          child: CardSearch(restaurant: restaurant),
                        );
                      },
                    );
                  }
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return Center(child: Text("Data tidak ditemukan"));
                }
              }
            },
          ),
        ),
      );
}
