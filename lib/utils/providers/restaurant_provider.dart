import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/api/result_state.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({@required this.apiService}) {
    _fetchAllRestaurant();
  }

  RestaurantResult _restaurantResult;
  String _message = '';
  ResultState _state;

  String get message => _message;
  RestaurantResult get result => _restaurantResult;
  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final data = await apiService.listRestaurant();

      if (data.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = data;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
