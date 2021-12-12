import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  User? _userFromFirebase(User? user) {
    return user ?? null;
  }

  Stream<User?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future signInAnon(StackTrace stackTrace) async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getUserCredentials() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

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
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: mail, password: pass);
      User user = result.user!;

      // Add user to database before returning to profile
      String userToken = await user.uid;

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
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: mail, password: pass);
      User user = result.user!;
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      return e.code.toString();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
