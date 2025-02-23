import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_questor/product/components/styles/firebase_service_constants.dart';
import 'package:crypto_questor/product/exports/exports.dart';
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
    var data = await FirebaseFirestore.instance
        .collection(FirebaseServiceConstants.users)
        .doc(uid)
        .get();
    if (data.exists) {
      personInfo.add(data.data() as Map<String, dynamic>);
    }
    return personInfo;
  }

  /// Fetches the portfolio coins list for the current user from Fire store
  Future<List<PortfolioCoinsModel>> getPortfolioCoins() async {
    final firebaseAuth = FirebaseAuth.instance;
    final snapshot = await FirebaseFirestore.instance
        .collection(firebaseAuth.currentUser!.uid)
        .orderBy(FirebaseServiceConstants.name)
        .get();
    return compute(_convertToPortfolioCoinsModel, snapshot.docs);
  }

  /// Converts Fire store documents to a list of [PortfolioCoinsModel]
  List<PortfolioCoinsModel> _convertToPortfolioCoinsModel(
      List<QueryDocumentSnapshot> docs) {
    return docs
        .map((doc) =>
            PortfolioCoinsModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  /// Updates a portfolio coin in Fire store
  Future<void> upToPortfolioCoin(
      Map<String, dynamic> upToInfo, String uid) async {
    await firebaseFireStore
        .collection(firebaseAuth.currentUser!.uid)
        .doc(uid)
        .set(upToInfo);
  }

  /// Deletes a coin transaction from the user's portfolio
  Future<void> deleteCoinTransaction(String uid) async {
    var ref = await firebaseFireStore
        .collection(firebaseAuth.currentUser!.uid)
        .doc(uid)
        .delete();
    return ref;
  }

  /// Signs in the user with email and password
  Future<String?> signIn(
      String email, String password, BuildContext context) async {
    String? res;
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      res = FirebaseServiceConstants.success;
    } on FirebaseAuthException catch (e) {
      // Handles different Firebase authentication errors
      switch (e.code) {
        case FirebaseServiceConstants.userNotFound:
          return res = context.mLocalizations.userNotFound;
        case FirebaseServiceConstants.invalidEmail:
          return res = context.mLocalizations.emailBadFormatted;
        case FirebaseServiceConstants.invalidCredential:
          return res = context.mLocalizations.emailOrPasswordIncorrect;
        case FirebaseServiceConstants.userDisabled:
          return res = context.mLocalizations.userDisabled;
        default:
          return res = context.mLocalizations.loginFailed;
      }
    }
    return res;
  }

  /// Signs up a new user with name, email, and password
  Future<String?> signUp(
    String name,
    String email,
    String password,
    BuildContext context,
  ) async {
    String? res;
    try {
      UserCredential credential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await firebaseFireStore
          .collection(FirebaseServiceConstants.users)
          .doc(credential.user!.uid)
          .set({
        FirebaseServiceConstants.name: name,
        FirebaseServiceConstants.email: email,
        FirebaseServiceConstants.uid: credential.user!.uid,
      });
      res = FirebaseServiceConstants.success;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case FirebaseServiceConstants.eMailAldreadyUse:
          return res = context.mLocalizations.emailAlreadyUseAnotherAccount;
        case FirebaseServiceConstants.weakPassword:
          return res = context.mLocalizations.weakPassword;
        case FirebaseServiceConstants.invalidEmail:
        case FirebaseServiceConstants.errorInvalidEmail:
          return res = context.mLocalizations.emailBadFormatted;
        default:
          return res = context.mLocalizations.signUpFailed;
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
