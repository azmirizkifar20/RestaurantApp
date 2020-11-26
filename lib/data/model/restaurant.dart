import 'dart:convert';

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  Menus menus;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      rating: json['rating'].toDouble(),
      menus: Menus.fromJson(json['menus']),
    );
  }
}

List<Restaurant> parseRestaurant(String json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json)['restaurants'];
  return parsed.map((e) => Restaurant.fromJson(e)).toList();
}

class Menus {
  List<Menu> foods;
  List<Menu> drinks;

  Menus({this.foods, this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods: List<Menu>.from(json["foods"].map((food) {
        return Menu.fromJson(food);
      })),
      drinks: List<Menu>.from(json["drinks"].map((drink) {
        return Menu.fromJson(drink);
      })),
    );
  }
}

class Menu {
  String name;

  Menu({this.name});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(name: json['name']);
  }
}
