import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../components/styles/firebase_service_constants.dart';
import '../../components/styles/project_exports.dart';

final class FirebaseExceptionManager {
  String handleFirebaseSignInError(
      FirebaseAuthException e, BuildContext context) {
    switch (e.code) {
      case FirebaseServiceConstants.userNotFound:
        return context.mLocalizations.userNotFound;
      case FirebaseServiceConstants.invalidEmail:
        return context.mLocalizations.emailBadFormatted;
      case FirebaseServiceConstants.invalidCredential:
        return context.mLocalizations.emailOrPasswordIncorrect;
      case FirebaseServiceConstants.userDisabled:
        return context.mLocalizations.userDisabled;
      default:
        return context.mLocalizations.loginFailed;
    }
  }

  /// Handles Firebase sign-up errors
  String handleFirebaseSignUpError(
      FirebaseAuthException e, BuildContext context) {
    switch (e.code) {
      case FirebaseServiceConstants.eMailAldreadyUse:
        return context.mLocalizations.emailAlreadyUseAnotherAccount;
      case FirebaseServiceConstants.weakPassword:
        return context.mLocalizations.weakPassword;
      case FirebaseServiceConstants.invalidEmail:
      case FirebaseServiceConstants.errorInvalidEmail:
        return context.mLocalizations.emailBadFormatted;
      default:
        return context.mLocalizations.signUpFailed;
    }
  }

  Future<void> saveUserToFireStore(String uid, String name, String email) async {
    final firebaseFireStore = FirebaseFirestore.instance;
    await firebaseFireStore.collection(FirebaseServiceConstants.users).doc(uid).set({
      FirebaseServiceConstants.name: name,
      FirebaseServiceConstants.email: email,
      FirebaseServiceConstants.uid: uid,
    });
  }
}
