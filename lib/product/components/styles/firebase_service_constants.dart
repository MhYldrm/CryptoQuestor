/// A utility class that defines constant values related to Firebase services.
///
/// This class contains static constants for Firestore collection names,
/// user attributes, and Firebase authentication error messages.
///
/// Using these constants helps maintain consistency and avoid typos
/// across the project when interacting with Firebase.
final class FirebaseServiceConstants {
  /// Private constructor to prevent instantiation.
  const FirebaseServiceConstants._();

  // ─────────────────── Firestore Collection Names ───────────────────

  /// Firestore collection name for storing user data.
  static const String users = "Users";

  // ─────────────────── User Attribute Keys ───────────────────

  /// Key for storing and retrieving a user's name.
  static const String name = 'name';

  /// Key for storing and retrieving a user's email.
  static const String email = 'email';

  /// Key for storing and retrieving a user's unique identifier (UID).
  static const String uid = 'uid';

  // ─────────────────── General Success Response ───────────────────

  /// A generic success response string.
  static const String success = "success";

  // ─────────────────── Firebase Authentication Error Codes ───────────────────

  /// Error code when an email is already associated with an existing account.
  static const String eMailAldreadyUse = "email-already-in-use";

  /// Error code when the provided password is too weak.
  static const String weakPassword = "weak-password";

  /// Error code when the provided email is invalid.
  static const String invalidEmail = "invalid-email";

  /// Error code when the provided credentials (email/password) are incorrect.
  static const String invalidCredential = "invalid-credential";

  /// Older version of invalid email error code (possibly deprecated).
  static const String errorInvalidEmail = "ERROR_INVALID_EMAİL";

  /// Error code when no user is found with the provided credentials.
  static const String userNotFound = "user-not-found";

  /// Error code when the user's account has been disabled by an admin.
  static const String userDisabled = "user-disabled";
}
