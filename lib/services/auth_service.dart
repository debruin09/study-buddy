// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:study_buddy/src/models/user.dart';
// import 'package:study_buddy/src/repositories/auth_repository.dart';
// import 'package:study_buddy/src/services/firestore_service.dart';

// class AuthService implements AuthRepository {
//   final _auth = FirebaseAuth.instance;

//   User _userFromFirebase(FirebaseUser user) {
//     return user != null
//         ? User(uid: user.uid)
//         : null; // convert firebase user to [Member] class
//   }

// // Check the state of a member
//   @override
//   Stream<User> get onAuthStateChange {
//     try {
//       return _auth.onAuthStateChanged.map(_userFromFirebase);
//     } catch (e) {
//       print("ERROR MESSAGE $e");
//       return null;
//     }
//   }

//   @override
//   Future<User> signInWithEmail({String email, String password}) async {
//     try {
//       final authResult = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       return _userFromFirebase(authResult.user);
//     } catch (e) {
//       print("ERROR MESSAGE $e");
//       return null;
//     }
//   }

//   @override
//   Future<void> signOut() async {
//     try {
//       print("User is signed out die man");
//       return await _auth.signOut();
//     } catch (e) {
//       print("ERROR MESSAGE $e");
//       return null;
//     }
//   }

//   @override
//   Future<User> createUser({String email, password, username}) async {
//     try {
//       final authResult = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);

//       await FirestoreService(myuid: authResult.user.uid).updateUserData(
//         username: username ?? "",
//         email: email ?? "",
//       );

//       return _userFromFirebase(authResult.user);
//     } catch (e) {
//       print("ERROR MESSAGE $e");
//       return null;
//     }
//   }

//   @override
//   Future<bool> isAuthenticated() async {
//     final currentUser = await _auth.currentUser();
//     // return true or false depending on whether we have a current user
//     return currentUser != null;
//   }

//   @override
//   Future<User> getUser() async {
//     FirebaseUser firebaseUser = await _auth.currentUser();
//     return User(uid: firebaseUser.uid, username: firebaseUser.displayName);
//   }
// }

