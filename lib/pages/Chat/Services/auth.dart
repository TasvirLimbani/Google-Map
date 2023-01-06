import 'package:demo/pages/Chat/Services/database.dart';
import 'package:demo/pages/Chat/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  LoginUser? _user({required User? user}) {
    return user != null ? LoginUser(uid: user.uid) : null;
  }

  Stream<LoginUser?> get user {
    return _auth.authStateChanges().map((user) => _user(user: user));
  }

  //
  Future<LoginUser?> registerwithEmailandPassword({email, password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await DatabaseService(uid: userCredential.user!.uid)
          .updateUserData(password: password, name: email);
      return _user(user: userCredential.user);
    } catch (e) {
      print("error" + e.toString());
      return null;
    }
  }

  Future<LoginUser?> signInwithEmailandPassword({email, password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return _user(user: userCredential.user);
    } catch (e) {
      print("error" + e.toString());
      return null;
    }
  }

// Signout Mathod
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
