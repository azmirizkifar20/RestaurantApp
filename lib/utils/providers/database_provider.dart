import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/result_state.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant_favorite.dart';
import 'package:restaurant_app/utils/providers/constants.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({@required this.databaseHelper});

  ResultState _state;
  ResultState get state => _state;
  String _message = '';
  String get message => _message;

  List<Favorite> _favorites = [];
  List<Favorite> get favorites => _favorites;

  void getFavorites() async {
    _favorites = await databaseHelper.getFavorites();

    if (_favorites.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = emptyMessage;
    }
    notifyListeners();
  }

  void addFavorite(Favorite restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      notifyListeners();
    } catch (e) {
      _state = ResultState.Error;
      _message = dbErrorMessage[0];
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      getFavorites();
      notifyListeners();
    } catch (e) {
      _state = ResultState.Error;
      _message = dbErrorMessage[1];
      notifyListeners();
    }
  }
}
