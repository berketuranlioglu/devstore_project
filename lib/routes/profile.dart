// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devstore_project/objects/users.dart';
import 'package:devstore_project/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:devstore_project/objects/profile_menu.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:devstore_project/routes/edit_profile.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

final User user = auth.currentUser!;
final uid = user.uid;

DBService db = DBService();

Future<String> userNameFinal = getUserName(uid);
final firestoreInstance = FirebaseFirestore.instance;
void printData() {
  firestoreInstance.collection('users').doc("password").get();
}

Future<Map<String, dynamic>?> getUser(String uid) async {
  var data =
      await firestoreInstance.collection("users").doc(uid).get().then((value) {
    return value.data();
  });
  return data;
}

Future<String> getUserName(String uid) async {
  var userData = {};
  userData = (await getUser(uid))!;
  var a = await getUser(uid);
  print(userData["username"]);
  return userData["username"];
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.userCollection.doc(user.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Users userClass =
              Users.fromJson(snapshot.data!.data() as Map<String, dynamic>);
          return Scaffold(
              body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network("${userClass.imageUrl}"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "${userClass.nameSurname}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Color(0xFF9441E4),
                  ),
                ),
                Text(
                  "${userClass.email}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 30),
                ProfileMenu(
                  text: "Orders",
                  icon: "assets/box.jpg",
                  press: () => {},
                ),
                ProfileMenu(
                  text: "Bookmarks",
                  icon: "assets/mark.png",
                  press: () {},
                ),
                ProfileMenu(
                  text: "Favorites",
                  icon: "assets/kalp.png",
                  press: () {},
                ),
                ProfileMenu(
                  text: "Reviews",
                  icon: "assets/comment.png",
                  press: () {},
                ),
                ProfileMenu(
                  text: "Account Information",
                  icon: "assets/man.png",
                  press: () {},
                ),
                ProfileMenu(
                  text: "Edit Profile",
                  icon: "assets/set.png",
                  press: () {
                    pushNewScreen(
                      context,
                      screen: editProfile(),
                    );
                  },
                ),
              ],
            ),
          ));
        }
        return Scaffold();
      },
    );
  }
}
