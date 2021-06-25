import 'package:booking_app/models/user.dart';
import 'package:booking_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static final instance = Authentication();
  final _firebaseAuth = FirebaseAuth.instance;
  BAUser _currentUser;

  Future<BAUser> logIn(final String email, final String password) async {
    try {
      final User user = (await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        final BAUser baUser = await Database.instance.findUser(user.uid);
        if (user != null) return baUser;
      }
    } on FirebaseAuthException catch (exception) {
      print(exception.message);
    }

    return null;
  }

  Future createAccount(
    final String fullName,
    final String email,
    final String password,
  ) async {
    try {
      final User user = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        final BAUser baUser = await Database.instance.createUser(
          uniqueID: user.uid,
          fullName: fullName,
          email: email,
        );
        if (baUser != null) return baUser;
      }
    } on FirebaseAuthException catch (exception) {
      print(exception);
      return exception.message;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    _currentUser = null;
  }

  BAUser getCurrentUser() {
    return _currentUser;
  }

  void setCurrentUser(final BAUser user) {
    _currentUser = user;
  }
}
