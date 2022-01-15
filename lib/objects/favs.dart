import 'package:flutter/material.dart';
import 'package:devstore_project/objects/product.dart';

class Favs {
  final Product product;
  final int numOfItem;

  Favs({required this.product, required this.numOfItem});
}

// Demo data for our cart
List<Favs> demoCarts = [
  Favs(product: demoProducts[0], numOfItem: 2),
  //Favs(product: demoProducts[1], numOfItem: 1),
  Favs(product: demoProducts[3], numOfItem: 3),
];