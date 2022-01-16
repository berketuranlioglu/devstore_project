// ignore_for_file: void_checks

import 'package:devstore_project/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? _userFromFirebase(User? user) {
    return user ?? null;
  }

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future signInAnon(StackTrace stackTrace) async {
    try {
      UserCredential result = await _firebaseAuth.signInAnonymously();
      User user = result.user!;
      user.updateEmail('false');
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getUserCredentials() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    try {
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return [credential, googleUser!.email];
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final credential = await getUserCredentials();

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential[0]);
    } on FirebaseAuthException catch (e) {
      //googleSignIn.disconnect();
      return e.message;
    } catch (e) {
      //googleSignIn.disconnect();
    }
  }

  Future signupWithMailAndPass(String mail, String pass, String phone,
      String username, String nameSurname) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: mail, password: pass);
      User user = result.user!;

      DBService dbService = DBService();
      String userToken = await user.uid;
      dbService.addUser(nameSurname, mail, userToken, phone, username, pass);

      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      return e.code.toString();
    } catch (e) {
      print(e.toString());
      String message = e.toString();
      return message;
    }
  }

  Future loginWithMailAndPass(String mail, String pass) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: mail, password: pass);
      User user = result.user!;

      if (user.photoURL == 'null') {
        user.updatePhotoURL('true');
      }
      if (user.photoURL == 'false') {
        return 'Disabled User';
      }
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      return e.code.toString();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
