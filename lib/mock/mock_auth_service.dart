import 'package:study_buddy/models/user.dart';
import 'package:study_buddy/repositories/auth_repository.dart';

class MockAuthService implements AuthRepository {
  // methods
  Stream<User> authStateStream() async* {
    for (int i = 0; i < 5; i++) {
      await Future.delayed(Duration(seconds: 1));
      yield User(username: "MyNameisTest");
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    return true;
  }

  @override
  Future<User> createUser({String email, password, username}) async {
    return User();
  }

  @override
  Future<User> signInWithEmail({String email, password}) async {
    return User();
  }

  @override
  Future<void> signOut() {
    return null;
  }

  @override
  Stream<User> get onAuthStateChange => authStateStream();

  @override
  Future<User> getUser() async {
    return User(uid: "myuid", username: "klue");
  }
}
