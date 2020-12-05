import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/api/result_state.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/providers/restaurant_search_provider.dart';
import 'package:restaurant_app/view/detail_page.dart';
import 'package:restaurant_app/widget/card_search.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchText = "";
  TextEditingController _searchEdit = new TextEditingController();
  final provider = RestaurantSearchProvider(apiService: ApiService());

  @override
  void initState() {
    provider.fetchSearchRestaurant(_searchText);
    super.initState();
  }

  _SearchPageState() {
    _searchEdit.addListener(() {
      setState(() {
        _searchText = _searchEdit.text;
        provider.fetchSearchRestaurant(_searchText);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (_) => provider,
      child: Scaffold(
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
          child: _consumer(),
        ),
      );

  Consumer<RestaurantSearchProvider> _consumer() => Consumer(
        builder: (context, value, _) {
          switch (value.state) {
            case ResultState.Loading:
              return Center(child: CircularProgressIndicator());
              break;

            case ResultState.HasData:
              return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 8),
                itemCount: value.result.founded,
                itemBuilder: (context, index) {
                  var restaurant = value.result.restaurants[index];
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
}
