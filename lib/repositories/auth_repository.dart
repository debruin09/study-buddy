import 'package:flutter/foundation.dart';
import 'package:study_buddy/models/user.dart';

abstract class AuthRepository {
  Future<User> createUser({@required String email, password, username});
  Future<void> signOut();
  Future<User> signInWithEmail({@required String email, String password});
  Stream<User> get onAuthStateChange;
  Future<bool> isAuthenticated();
  Future<User> getUser();
}
