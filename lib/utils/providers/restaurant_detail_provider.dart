import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/api/result_state.dart';
import 'package:restaurant_app/data/model/add_review.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantDetailProvider({@required this.apiService});

  RestaurantDetailResult _detailResult;
  AddReviewResult _reviewResult;
  String _message = '';
  ResultState _state;

  String get message => _message;
  RestaurantDetailResult get result => _detailResult;
  AddReviewResult get reviewResult => _reviewResult;
  ResultState get state => _state;

  Future<dynamic> fetchDetailRestaurant(String id) async {
    try {
      print("get detail terpanggil");
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

  Future<dynamic> addReview(Map dataReview) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      String body = json.encode(dataReview);
      final data = await apiService.addReview(body);

      if (data.customerReviews.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _reviewResult = data;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
