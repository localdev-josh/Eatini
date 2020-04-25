import 'package:flutter/foundation.dart';

FooditemList fooditemList = FooditemList(foodItems: [
  FoodItem(
      id: 1,
      title: "Spaghetti and Turkey",
      restaurant: "Korede Spaghetti",
      restaurantLocation: "Unilag",
      price: 14.49,
      deliveryDuration: "25-30",
      rating: "4.7",
      imgUrl: "assets/images/noodles.jpg",
      foodUrl: "assets/images/pasta.jpg"),
  FoodItem(
      id: 2,
      title: "Creame Salade",
      restaurant: "Salado Restaurant",
      restaurantLocation: "Unilag",
      price: 11.99,
      deliveryDuration: "30-35",
      rating: "4.5",
      imgUrl: "assets/images/salad.jpg",
      foodUrl: "assets/images/saladee.jpg"),
  FoodItem(
      id: 3,
      title: "Meat assortment soup",
      restaurant: "Iya Morriah Restaurant",
      restaurantLocation: "Unilag",
      price: 8.49,
      deliveryDuration: "10-15",
      rating: "4.8",
      imgUrl: "assets/images/soup.jpg",
      foodUrl: "assets/images/squidsoup.jpg"),
]);

class FooditemList {
  List<FoodItem> foodItems;

  FooditemList({@required this.foodItems});
}

class FoodItem {
  int id;
  String title;
  String restaurant;
  String restaurantLocation;
  double price;
  String deliveryDuration;
  String rating;
  String imgUrl;
  String foodUrl;
  int quantity;

  FoodItem({
    this.id,
    this.title,
    this.restaurant,
    this.restaurantLocation,
    this.price,
    this.deliveryDuration,
    this.rating,
    this.imgUrl,
    this.foodUrl,
    this.quantity = 1,
  });

  void incrementQuantity() {
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity() {
    this.quantity = this.quantity - 1;
  }
}
