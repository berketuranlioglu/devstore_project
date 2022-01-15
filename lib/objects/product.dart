import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });
}

// DEMO PRODUCTS, BURAYA SONRA DATABASEDEN GELECEK

List<Product> demoProducts = [
  Product(
    id: 1,
    images: [
      "assets/ps4_console_white_1.png",
      "assets/ps4_console_white_2.png",
      "assets/ps4_console_white_3.png",
      "assets/ps4_console_white_4.png",
    ],
    colors: [
      Colors.white,
    ],
    title: "PS4™ Wireless Controller ",
    price: 54.99,
    description: "ps4",
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),

  Product(
    id: 2,
    images: [
      "assets/ps4_console_white_2.png",
    ],
    colors: [
      Colors.white,
    ],
    title: "Controller for PS3",
    price: 50,
    description: ".",
    rating: 3.2,
    isPopular: true,
  ),

  Product(
    id: 3,
    images: [
      "assets/ps4_console_white_2.png",
    ],
    colors: [
      Colors.white,
    ],
    title: "PS5",
    price: 36.55,
    description: "Gloves",
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),

  Product(
    id: 4,
    images: [
      "assets/wireless headset.png",
    ],
    colors: [
      Colors.white,
    ],
    title: "Logitech Head",
    price: 20.20,
    description: "Logitech Head",
    rating: 4.1,
    isFavourite: true,
  ),
];