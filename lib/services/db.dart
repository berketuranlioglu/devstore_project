import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  final firestoreInstance = FirebaseFirestore.instance;

  Future addUserAutoID(String nameSurname, String mail, String token) async {
    firestoreInstance
        .collection("users")
        .add({'nameSurname': nameSurname, 'userToken': token, 'email': mail})
        .then((value) => print('User added'))
        .catchError((error) => print('Error: ${error.toString()}'));
  }

  Future addUser(String nameSurname, String mail, String token, String phone,
      String username, String password) async {
    firestoreInstance
        .collection("users")
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
        })
        .then((value) => print('User added'))
        .catchError((error) => print('Error: ${error.toString()}'));
  }

  Future editDetails(String nameSurname, String token, String imageUrl,
      String phone, String password) async {
    firestoreInstance
        .collection("users")
        .doc(token)
        .update({
          'password': password,
          'imageUrl': imageUrl,
        })
        .then((value) => print('User added'))
        .catchError((error) => print('Error: ${error.toString()}'));
  }
}
