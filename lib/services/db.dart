import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future addUserAutoID(String nameSurname, String mail, String token) async {
    userCollection
        .add({'nameSurname': nameSurname, 'userToken': token, 'email': mail})
        .then((value) => print('User added'))
        .catchError((error) => print('Error: ${error.toString()}'));
  }

  Future addUser(String nameSurname, String mail, String token, String phone,
      String username, String password) async {
    userCollection.doc(token).set({
      'nameSurname': nameSurname,
      'username': username,
      'userToken': token,
      'phone': phone,
      'email': mail,
      'password': password,
    });
  }
}
