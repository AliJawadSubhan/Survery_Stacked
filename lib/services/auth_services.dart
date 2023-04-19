import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<bool> loginService(String email, String password) async {
// trry
    try {
      await login(email, password);
      return true;
    } catch (e) {
      try {
        await create(email, password);
        return true;
      } catch (e) {
        return false;
      }
    }
  }

  String? get email => FirebaseAuth.instance.currentUser?.email;

  login(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    //  userCredential.user.displayName;
  }

  create(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    //  userCredential.user.displayName;
  }
}
