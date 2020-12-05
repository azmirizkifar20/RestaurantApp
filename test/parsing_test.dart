import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/restaurant_favorite.dart';

void main() {
  test('test parsing data favorite', () {
    // act
    var data = Favorite.fromJson(json);

    // assert
    expect((data.id == object.id), true);
    expect((data.name == object.name), true);
    expect((data.description == object.description), true);
    expect((data.city == object.city), true);
    expect((data.address == object.address), true);
    expect((data.pictureId == object.pictureId), true);
    expect((data.rating == object.rating), true);
  });
}

const json = {
  "id": "rqdv5juczeskfw1e867",
  "name": "Melting Pot",
  "description":
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
  "city": "Medan",
  "address": "Jln. Pandeglang no 19",
  "pictureId": "14",
  "rating": 4.2
};

Favorite object = Favorite(
  id: "rqdv5juczeskfw1e867",
  name: "Melting Pot",
  description:
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
  city: "Medan",
  address: "Jln. Pandeglang no 19",
  pictureId: "14",
  rating: 4.2,
);
