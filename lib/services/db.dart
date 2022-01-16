import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devstore_project/routes/edit_product.dart';

class DBService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection("products");

  Future addUserAutoID(String nameSurname, String mail, String token) async {
    userCollection
        .add({'nameSurname': nameSurname, 'userToken': token, 'email': mail})
        .then((value) => print('User added'))
        .catchError((error) => print('Error: ${error.toString()}'));
  }

  Future addUser(String nameSurname, String mail, String token, String phone,
      String username, String password) async {
    userCollection
        .doc(token)
        .set({
          'nameSurname': nameSurname,
          'username': username,
          'userToken': token,
          'phone': phone,
          'email': mail,
          'password': password,
          'imageUrl': 'https://i.stack.imgur.com/l60Hf.png',
          'isActive': true,
          'rating': 0.0,
          'productReference': [],
          'cart': [],
          'comments': [],
          'orders': [],
          'favorites': [],
          'bookmarks': [],
        })
        .then((value) => print('User added'))
        .catchError((error) => print('Error: ${error.toString()}'));
  }

  Future addGuestUser(String token) async {
    userCollection
        .doc(token)
        .set({
          'nameSurname': 'null',
          'username': 'null',
          'userToken': token,
          'phone': 'null',
          'email': 'null',
          'password': '123456789',
          'imageUrl': 'https://i.stack.imgur.com/l60Hf.png',
          'isActive': true,
          'rating': 0.0,
          'productReference': [],
          'cart': [],
          'comments': [],
          'orders': [],
          'favorites': [],
          'bookmarks': [],
        })
        .then((value) => print('User added'))
        .catchError((error) => print('Error: ${error.toString()}'));
  }

  Future editDetails(String token, String password, String imageUrl) async {
    userCollection
        .doc(token)
        .update({
          'password': password,
          'imageUrl': imageUrl,
        })
        .then((value) => print('Data Changed'))
        .catchError((error) => print('Error: ${error.toString()}'));
  }

  Future disableUser(String token) async {
    userCollection
        .doc(token)
        .update({
          'isActive': false,
        })
        .then((value) => print('Data Changed'))
        .catchError((error) => print('Error: ${error.toString()}'));
  }

  Future editProductDetails(String token, String nameDescription,
      String details, String imageURL, int price) async {
    productsCollection
        .doc(token)
        .update({
          'salePrice': price,
          'productName': nameDescription,
          'details': details,
          'imageURL': imageURL,
        })
        .then((value) => print('Data Changed'))
        .catchError((error) => print('Error: ${error.toString()}'));
  }

  Future addItem(
      String productName,
      String categoryName,
      String productDescription,
      int productPrice,
      List imageUrl,
      String token,
      String username,
      String prodToken) async {
    productsCollection
        .doc(prodToken)
        .set({
          'category': categoryName,
          'comments': [],
          'location': null,
          'overview': 'Ipsum',
          'previousPrice': productPrice,
          'salePrice': productPrice,
          'sellerName': username,
          'stockCount': 1,
          'rating': 0.0,
          'ratingCount': 0,
          'details': productDescription,
          'productName': productName,
          'productBrand': productName + ' ltd',
          'imageURL': imageUrl,
          'isActive': true,
          'sellerReference': '/users/' + token,
        })
        .then((value) => print('Item added'))
        .catchError((error) => print('Error: ${error.toString()}'));
  }

  Future deleteUser(String token) async {
    userCollection.doc(token).delete();
  }

  Future deleteProduct(String token) async {
    productsCollection.doc(token).delete();
  }
}
