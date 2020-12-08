import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';
import 'package:restaurant_app/providers/restaurant_search_provider.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  group('Provider Test', () {
    RestaurantSearchProvider restaurantSearchProvider;
    ApiService apiService;

    setUp(() {
      // arrange
      var search = "Makan mudah";
      apiService = MockApiService();
      restaurantSearchProvider =
          RestaurantSearchProvider(apiService: apiService);

      // action
      when(apiService.searchRestaurant(search)).thenAnswer(
          (_) async => RestaurantSearchResult.fromJson(apiResponse));
      restaurantSearchProvider.fetchSearchRestaurant(search);
    });

    test('Cek hasil parsing data dari API Restaurant', () async {
      // arrange
      var result = restaurantSearchProvider.result.restaurants[0];
      var jsonRestaurant = Restaurant.fromJson(testSearch);

      // assert
      expect(result.id == jsonRestaurant.id, true);
      expect(result.name == jsonRestaurant.name, true);
      expect(result.description == jsonRestaurant.description, true);
      expect(result.pictureId == jsonRestaurant.pictureId, true);
      expect(result.city == jsonRestaurant.city, true);
      expect(result.rating == jsonRestaurant.rating, true);
    });
  });
}

const apiResponse = {
  "error": false,
  "founded": 1,
  "restaurants": [
    {
      "id": "fnfn8mytkpmkfw1e867",
      "name": "Makan mudah",
      "description":
          "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, ...",
      "pictureId": "22",
      "city": "Medan",
      "rating": 3.7
    }
  ]
};

const testSearch = {
  "id": "fnfn8mytkpmkfw1e867",
  "name": "Makan mudah",
  "description":
      "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, ...",
  "pictureId": "22",
  "city": "Medan",
  "rating": 3.7
};
