import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy/models/card.dart';
import 'package:study_buddy/models/deck.dart';

import 'package:study_buddy/models/user.dart';
import 'package:study_buddy/repositories/database_repository.dart';

class FirestoreService implements DatabaseRepository {
  final CollectionReference deckCollection =
      Firestore.instance.collection("decks");
  final CollectionReference userCollection =
      Firestore.instance.collection("users");

  final String myuid;

  @override
  String get uid => myuid;

  FirestoreService({
    @required this.myuid,
  }) : assert(myuid != null);

  User _userDataFromSnapShot(DocumentSnapshot snapshot) {
    try {
      return User(uid: uid, username: snapshot.data["username"]);
    } catch (e) {
      print("Error from user snapshot: $e");
      return null;
    }
  }

  List<Deck> _decksFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((snapshot) => Deck(
            cards: snapshot.data["cards"],
            deckName: snapshot.data["deckName"],
            lastCreated: snapshot.data["lastCreated"],
            tags: snapshot.data["tags"]))
        .toList();
  }

// updates users data in the database
  @override
  Future<void> updateUserData({
    String username,
    String email,
    bool challenge,
  }) async {
    return await userCollection.document(uid).setData({
      "username": username,
      "email": email,
      "challenge": challenge,
    });
  }

// create new deck
  @override
  Future<void> createNewDeck(String deckName, {List<CardEntity> cards}) async {
    try {
      return await deckCollection.document(uid).setData({
        "deckName": deckName,
        "cards": cards ?? [],
      });
    } catch (e) {
      print(e.message);
    }
  }

// gets all the user from the database
  @override
  Stream<User> get userData {
    try {
      return userCollection
          .document(uid)
          .snapshots()
          .map((snapshot) => _userDataFromSnapShot(snapshot));
    } catch (e) {
      print("Error from firestore: $e");
      return null;
    }
  }

  @override
  Stream<List<Deck>> get decks {
    return deckCollection
        .document(uid)
        .collection('mydata')
        .snapshots()
        .map((snapshot) => _decksFromSnapShot(snapshot));
  }

  @override
  String toString() => 'FirestoreService(uid: $uid)';

  @override
  Future<void> deleteDeck({String id}) async {
    return await deckCollection.document(id).delete();
  }

  @override
  Stream<CardEntity> get singleCard => throw UnimplementedError();
}
