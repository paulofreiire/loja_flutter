import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;

  Map<String, dynamic> userData = Map();
  bool isLoading = false;

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSucecess,
      @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: pass)
        .then((auth) async {

      firebaseUser = auth.user;

      await _saveUserData(userData);

      onSucecess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      print(e);
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn() async {
    isLoading = true;
    notifyListeners();

    isLoading = false;
    notifyListeners();
  }

  void recoverPass() {
    signUp(userData: null, pass: null, onSucecess: null, onFail: null);
  }

  bool isLoggedIn() {}

  Future<Null> _saveUserData(Map<String, dynamic> userData) {
    this.userData = userData;
    Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .setData(userData);
  }
}
