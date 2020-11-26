import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/api/result_state.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({@required this.apiService, @required this.id}) {
    _fetchDetailRestaurant(id);
  }

  RestaurantDetailResult _detailResult;
  String _message = '';
  ResultState _state;

  String get message => _message;
  RestaurantDetailResult get result => _detailResult;
  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final data = await apiService.detailRestaurant(id);

      if (data.restaurant == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _detailResult = data;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
