import 'package:VTOP_Extended/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user Object based on FirebaseUser
  // User _userFromFirebaseUser(FirebaseUser user) {
  //   return user != null ? User(uid: user.uid) : null;
  // }

  //Auth change User Stream
  Stream<User> get user {
    // return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
    return _auth.authStateChanges();
  }

  //Sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      sendEmailVerification();
      await DatabaseService(uid: user.uid)
          .updateUserData("Unknown", user.email, "Rollno", ["Clubnames"]);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  //User Verification
  Future<void> sendEmailVerification() async {
    User user = _auth.currentUser;
    user.sendEmailVerification();
  }

  //Email Verified
  Future<bool> isEmailVerified() async {
    User user = _auth.currentUser;
    await user.reload();
    return user.emailVerified;
  }

  User currentUser() {
    User user = _auth.currentUser;
    return user;
  }
}
