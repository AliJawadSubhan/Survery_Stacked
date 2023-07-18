import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked_tech_idara/base/app.locator.dart';
import 'package:stacked_tech_idara/services/db_services.dart';

class AuthService {
  final fireStoreService = locator<FireStoreServices>();

  Future<bool> loginService(String username) async {
// trry

    try {
      await createGuestUser(username);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  createGuestUser(String username) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    String userUid = userCredential.user!.uid;
    await fireStoreService.sendUsertoDatabase(username, userUid);
    //  userCredential.user.displayName;
  }

  String? get userUid => FirebaseAuth.instance.currentUser?.uid;

  logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
