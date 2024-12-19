import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/portfolio_coins_model.dart';

/// [FirebaseService] Manages Firebase authentication and Fire store operations
///
class FirebaseService {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFireStore = FirebaseFirestore.instance;

  /// Retrieves user information based on their [uid] from Fire store
  Future<List> getInfo(String uid) async {
    List personInfo = [];
    var data = await FirebaseFirestore.instance.collection("Users").doc(uid).get();
    if (data.exists) {
      personInfo.add(data.data() as Map<String, dynamic>);
    }
    return personInfo;
  }

  /// Fetches the portfolio coins list for the current user from Fire store
  Future<List<PortfolioCoinsModel>> getPortfolioCoins () async{
    final firebaseAuth = FirebaseAuth.instance;
    final snapshot = await FirebaseFirestore.instance
        .collection(firebaseAuth.currentUser!.uid)
        .orderBy("name")
        .get();
    return compute(_convertToPortfolioCoinsModel, snapshot.docs);
  }

  /// Converts Fire store documents to a list of [PortfolioCoinsModel]
  List<PortfolioCoinsModel> _convertToPortfolioCoinsModel(List<QueryDocumentSnapshot> docs) {
    return docs.map((doc) => PortfolioCoinsModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
  }

  /// Updates a portfolio coin in Fire store
  Future<void> upToPortfolioCoin(Map<String, dynamic> upToInfo,String uid) async {
    await firebaseFireStore
        .collection(firebaseAuth.currentUser!.uid)
        .doc(uid)
        .set(upToInfo);
  }

  /// Deletes a coin transaction from the user's portfolio
  Future<void> deleteCoinTransaction(String uid)async{
    var ref = await firebaseFireStore.collection(firebaseAuth.currentUser!.uid)
        .doc(uid)
        .delete();
    return ref;
  }

  /// Signs in the user with email and password
  Future<String?> signIn(String email, String password) async {
    String? res;
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      res = "success";
    } on FirebaseAuthException catch (e) {
      // Handles different Firebase authentication errors
      switch (e.code) {
        case "user-not-found":
          return res = "User Not Found";
        case "invalid-email":
          return res = "The email address is badly formatted.";
        case "invalid-credential":
          return res = "Email or Password is incorrect";
        case "user-disabled":
          return res = "User Disabled";
        default:
          return res = "Login Failed. Please Try Again.";
      }
    }
    return res;
  }

  /// Signs up a new user with name, email, and password
  Future<String?> signUp(
      String name,
      String email,
      String password,
      ) async {
    String? res;
    try {
      UserCredential credential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await firebaseFireStore
          .collection("Users")
          .doc(credential.user!.uid)
          .set({
        'name': name,
        'email': email,
        'uid': credential.user!.uid,
      });
      res = "success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return res =
          "The email address is already in use by another account.";
        case "weak-password":
          return res =
          "Weak Password.\nPassword should be at least 6 characters";
        case "invalid-email":
        case "ERROR_INVALID_EMAİL":
          return res = "The email address is badly formatted.";
        default:
          return res = "Sign Up Failed. Please Try Again.";
      }
    }
    return res;
  }

  /// User auth info
  bool isAuthenticated() {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  /// Signs out the current user
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}