import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/api/result_state.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';
import 'package:restaurant_app/utils/constants.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({@required this.apiService});

  RestaurantSearchResult _searchResult;
  String _message = '';
  ResultState _state;

  String get message => _message;
  RestaurantSearchResult get result => _searchResult;
  ResultState get state => _state;

  Future<dynamic> fetchSearchRestaurant(String search) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final data = await apiService.searchRestaurant(search);

      if (data.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = emptyMessage;
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _searchResult = data;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = errorMessage;
    }
  }
}
