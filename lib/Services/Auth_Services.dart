// ignore_for_file: avoid_print, file_names

import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  //LOGIN

  Future<String> login(String emailAddress, String password) async {
    String res = 'Some Error...';

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      res = 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        res = "No User Found";
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        res = "Wrong Password";
      }
    }

    return res;
  }

  //Sign Up

  Future<String> signUp(String emailAddress, String password) async {
    String res = 'Some Error...';

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      res = 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        res = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        res = 'The account already exists for that email.';
      }
    } catch (e) {
      print(e);
    }

    return res;
  }

  //Sign Out

  Future<String> signOut() async {
    String res = 'Some error...';

    try {
      await FirebaseAuth.instance.signOut();
      res = 'Success';
    } on FirebaseAuthException catch (e) {
      res = e.code;
    }

    return res;
  }

  //Reset Password

  Future<String> resetPassword(String email) async {
    String res = 'Some Error...';

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );

      res = 'Success';
    } on FirebaseAuthException catch (e) {
      res = e.code;
    }

    return res;
  }
}
