import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/add_review.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/providers/restaurant_detail_provider.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  group('Provider Test', () {
    RestaurantDetailProvider restaurantDetailProvider;
    ApiService apiService;

    setUp(() {
      // arrange
      apiService = MockApiService();
      restaurantDetailProvider =
          RestaurantDetailProvider(apiService: apiService);
      var id = "s1knt6za9kkfw1e867";

      // action get detail
      when(apiService.detailRestaurant(id)).thenAnswer(
          (_) async => RestaurantDetailResult.fromJson(apiResponse));
      restaurantDetailProvider.fetchDetailRestaurant(id);

      // action add review
      when(apiService.addReview(json.encode(body)))
          .thenAnswer((_) async => AddReviewResult.fromJson(addReviewResponse));
      restaurantDetailProvider.addReview(body);
    });

    test('Cek hasil response detail restaurant', () async {
      // arrange
      var result = restaurantDetailProvider.result.restaurant;
      var jsonRestaurant = Restaurant.fromJson(testRestaurant);

      // assert
      expect(result.id == jsonRestaurant.id, true);
      expect(result.name == jsonRestaurant.name, true);
      expect(result.description == jsonRestaurant.description, true);
      expect(result.city == jsonRestaurant.city, true);
      expect(result.address == jsonRestaurant.address, true);
      expect(result.pictureId == jsonRestaurant.pictureId, true);
      expect(result.rating == jsonRestaurant.rating, true);
    });

    test('cek hasil response add review', () async {
      // arrange
      var result = restaurantDetailProvider.reviewResult.customerReviews[1];
      var jsonReview = CustomerReview.fromJson(testReview);

      // assert
      expect(result.date == jsonReview.date, true);
      expect(result.name == jsonReview.name, true);
      expect(result.review == jsonReview.review, true);
    });
  });
}

const body = {
  "id": "s1knt6za9kkfw1e867",
  "name": "Muhamad Azmi Rizkifar",
  "review": "Tempatnya bagus dan murah"
};

const testRestaurant = {
  "id": "s1knt6za9kkfw1e867",
  "name": "Kafe Kita",
  "description":
      "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
  "city": "Gorontalo",
  "address": "Jln. Pustakawan no 9",
  "pictureId": "25",
  "categories": [
    {"name": "Sop"},
    {"name": "Modern"}
  ],
  "menus": {
    "foods": [
      {"name": "Kari kacang dan telur"},
      {"name": "Ikan teri dan roti"},
      {"name": "roket penne"},
      {"name": "Salad lengkeng"},
      {"name": "Tumis leek"},
      {"name": "Salad yuzu"},
      {"name": "Sosis squash dan mint"}
    ],
    "drinks": [
      {"name": "Jus tomat"},
      {"name": "Minuman soda"},
      {"name": "Jus apel"},
      {"name": "Jus mangga"},
      {"name": "Es krim"},
      {"name": "Kopi espresso"},
      {"name": "Jus alpukat"},
      {"name": "Coklat panas"},
      {"name": "Es kopi"},
      {"name": "Teh manis"},
      {"name": "Sirup"},
      {"name": "Jus jeruk"}
    ]
  },
  "rating": 4,
  "customerReviews": [
    {
      "name": "Ahmad",
      "review": "Tidak ada duanya!",
      "date": "13 November 2019"
    },
    {
      "name": "Arif",
      "review": "Tidak rekomendasi untuk pelajar!",
      "date": "13 November 2019"
    },
    {
      "name": "Gilang",
      "review": "Tempatnya bagus namun menurut saya masih sedikit mahal.",
      "date": "14 Agustus 2018"
    }
  ]
};

const apiResponse = {
  "error": false,
  "message": "success",
  "restaurant": {
    "id": "s1knt6za9kkfw1e867",
    "name": "Kafe Kita",
    "description":
        "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
    "city": "Gorontalo",
    "address": "Jln. Pustakawan no 9",
    "pictureId": "25",
    "categories": [
      {"name": "Sop"},
      {"name": "Modern"}
    ],
    "menus": {
      "foods": [
        {"name": "Kari kacang dan telur"},
        {"name": "Ikan teri dan roti"},
        {"name": "roket penne"},
        {"name": "Salad lengkeng"},
        {"name": "Tumis leek"},
        {"name": "Salad yuzu"},
        {"name": "Sosis squash dan mint"}
      ],
      "drinks": [
        {"name": "Jus tomat"},
        {"name": "Minuman soda"},
        {"name": "Jus apel"},
        {"name": "Jus mangga"},
        {"name": "Es krim"},
        {"name": "Kopi espresso"},
        {"name": "Jus alpukat"},
        {"name": "Coklat panas"},
        {"name": "Es kopi"},
        {"name": "Teh manis"},
        {"name": "Sirup"},
        {"name": "Jus jeruk"}
      ]
    },
    "rating": 4,
    "customerReviews": [
      {
        "name": "Ahmad",
        "review": "Tidak ada duanya!",
        "date": "13 November 2019"
      },
      {
        "name": "Arif",
        "review": "Tidak rekomendasi untuk pelajar!",
        "date": "13 November 2019"
      },
      {
        "name": "Gilang",
        "review": "Tempatnya bagus namun menurut saya masih sedikit mahal.",
        "date": "14 Agustus 2018"
      }
    ]
  }
};

const testReview = {
  "name": "Muhamad Azmi Rizkifar",
  "review": "Tempatnya bagus dan murah",
  "date": "8 Desember 2020"
};

const addReviewResponse = {
  "error": false,
  "message": "success",
  "customerReviews": [
    {
      "name": "Ahmad",
      "review": "Tidak rekomendasi untuk pelajar!",
      "date": "13 November 2019"
    },
    {
      "name": "Muhamad Azmi Rizkifar",
      "review": "Tempatnya bagus dan murah",
      "date": "8 Desember 2020"
    }
  ]
};
