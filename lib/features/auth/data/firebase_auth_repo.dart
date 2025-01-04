import 'package:firebase_auth/firebase_auth.dart';

import '../domain/entities/app_user.dart';
import '../domain/repos/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      // atempt sign in
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // create a user
      AppUser user =
          AppUser(uid: userCredential.user!.uid, email: email, name: '');

      // return user
      return user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
      String name, String email, String password) async {
    // TODO: implement registerWithEmailPassword
    try {
      // atempt sign up
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // create a user
      AppUser user =
          AppUser(uid: userCredential.user!.uid, email: email, name: name);

      // return user
      return user;
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    // TODO: implement logout
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    // TODO: implement getCurrentUser
    final firebaseUser = firebaseAuth.currentUser;
    if (firebaseUser == null) {
      return null;
    }
    return AppUser(uid: firebaseUser.uid, email: firebaseUser.email!, name: '');
  }
}
