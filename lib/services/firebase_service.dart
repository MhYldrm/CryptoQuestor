import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFireStore = FirebaseFirestore.instance;

  Future<void> upToPortfolioCoin(Map<String, dynamic> upToInfo,String uid) async {
    await firebaseFireStore
        .collection(firebaseAuth.currentUser!.uid)
        .doc(uid)
        .set(upToInfo);
  }


  Future<void> deleteCoinTransaction(String uid)async{
    var ref = await firebaseFireStore.collection(firebaseAuth.currentUser!.uid)
        .doc(uid)
        .delete();
    return ref;
  }

  Future<String?> signIn(String email, String password) async {
    String? res;
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      res = "success";
    } on FirebaseAuthException catch (e) {
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

  Future<String?> signUp(
      String name,
      String email,
      String password,
      ) async {
    String? res;
    try {
      UserCredential credential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      try {
        await firebaseFireStore
            .collection("Users")
            .doc(credential.user!.uid)
            .set({
          'name': name,
          'email': email,
          'uid': credential.user!.uid,
        });
      } catch (e) {
        print("$e");
      }
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

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
