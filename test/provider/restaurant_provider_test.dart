import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/providers/restaurant_provider.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  group('Provider Test', () {
    RestaurantProvider restaurantProvider;
    ApiService apiService;

    setUp(() {
      // arrange
      apiService = MockApiService();
      when(apiService.listRestaurant())
          .thenAnswer((_) async => RestaurantResult.fromJson(apiResponse));
      restaurantProvider = RestaurantProvider(apiService: apiService);
    });

    test('Cek hasil parsing data dari API Restaurant', () async {
      // arrange
      var result = restaurantProvider.result.restaurants[0];
      var jsonRestaurant = Restaurant.fromJson(testRestaurant);

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
  "message": "success",
  "count": 1,
  "restaurants": [
    {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    }
  ]
};

const testRestaurant = {
  "id": "rqdv5juczeskfw1e867",
  "name": "Melting Pot",
  "description":
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
  "pictureId": "14",
  "city": "Medan",
  "rating": 4.2
};
