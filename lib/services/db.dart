import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future deleteUser(String token) async {
    userCollection.doc(token).delete();
  }
}
