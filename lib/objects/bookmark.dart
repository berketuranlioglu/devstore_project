import 'package:flutter/material.dart';
import 'package:devstore_project/objects/product.dart';

class Bookmark {
  final Product product;
  final int numOfItem;

  Bookmark({required this.product, required this.numOfItem});
}

// Demo data for our cart
List<Bookmark> demoCarts = [
  Bookmark(product: demoProducts[0], numOfItem: 2),
  //Favs(product: demoProducts[1], numOfItem: 1),
  Bookmark(product: demoProducts[3], numOfItem: 3),
];