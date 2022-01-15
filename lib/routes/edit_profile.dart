import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devstore_project/objects/users.dart';
import 'package:devstore_project/routes/account_info.dart';
import 'package:devstore_project/routes/profile.dart';
import 'package:devstore_project/services/db.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class editProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

final FirebaseAuth auth = FirebaseAuth.instance;

final User user = auth.currentUser!;
final uid = user.uid;

DBService db = DBService();

String pass1 = "";
String pass2 = "";
String imageUrl = "";
final _formKey = GlobalKey<FormState>();

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

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
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
            body: Container(
              padding: EdgeInsets.only(left: 16, top: 40, right: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    const Text(
                      "Edit Profile",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network("${userClass.imageUrl}"),
                    ),
                    SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(24, 24, 24, 4),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            fillColor: Colors.grey[200],
                                            filled: true,
                                            hintText: 'Image URL',
                                            hintStyle:
                                                const TextStyle(fontSize: 14.0),
                                            prefixIcon: const Icon(Icons.image,
                                                color: Colors.grey),
                                            contentPadding:
                                                const EdgeInsets.all(12.0),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Image URL field cannot be empty!';
                                            } else {
                                              String trimmedValue =
                                                  value.trim();
                                              if (trimmedValue.isEmpty) {
                                                return 'Image URL field cannot be empty!';
                                              }
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            if (value != null) {
                                              imageUrl = value;
                                            }
                                          },
                                          onChanged: (value) {
                                            if (value != null) {
                                              imageUrl = value;
                                            }
                                          },
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            fillColor: Colors.grey[200],
                                            filled: true,
                                            hintText: 'Password',
                                            hintStyle:
                                                const TextStyle(fontSize: 14.0),
                                            prefixIcon: const Icon(
                                                Icons.lock_outlined,
                                                color: Colors.grey),
                                            contentPadding:
                                                const EdgeInsets.all(12.0),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                            ),
                                          ),
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          obscureText: true,
                                          enableSuggestions: false,
                                          autocorrect: false,
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Password field cannot be empty';
                                            } else {
                                              String trimmedValue =
                                                  value.trim();
                                              if (trimmedValue.isEmpty) {
                                                return 'Password field cannot be empty';
                                              }
                                              if (trimmedValue.length < 8) {
                                                return 'Password must be at least 8 characters long';
                                              }
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            if (value != null) {
                                              pass1 = value;
                                            }
                                          },
                                          onChanged: (value) {
                                            if (value != null) {
                                              pass1 = value;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            fillColor: Colors.grey[200],
                                            filled: true,
                                            hintText: 'Confirm Password',
                                            hintStyle:
                                                const TextStyle(fontSize: 14.0),
                                            prefixIcon: const Icon(
                                                Icons.lock_outline,
                                                color: Colors.grey),
                                            contentPadding:
                                                const EdgeInsets.all(12.0),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                            ),
                                          ),
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          obscureText: true,
                                          enableSuggestions: false,
                                          autocorrect: false,
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Password field cannot be empty';
                                            } else {
                                              String trimmedValue =
                                                  value.trim();
                                              if (trimmedValue.isEmpty) {
                                                return 'Password field cannot be empty';
                                              }
                                              if (trimmedValue.length < 8) {
                                                return 'Password must be at least 8 characters long';
                                              }
                                              if (value != pass1) {
                                                return 'Please enter the same password';
                                              }
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            if (value != null) {
                                              pass2 = value;
                                            }
                                          },
                                          onChanged: (value) {
                                            if (value != null) {
                                              pass2 = value;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Form(
                                    child: FlatButton(
                                      child: Text(
                                        'Edit Profile ',
                                        style: signupPage_ButtonTxts,
                                      ),
                                      color: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Editing the Profile!')));
                                          db.editDetails(uid, pass1, imageUrl);
                                        }
                                        pushNewScreen(context,
                                            screen: accountView());
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Scaffold();
      },
    );
  }
}
