import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:study_buddy/models/card.dart';
import 'package:study_buddy/models/deck.dart';
import 'package:study_buddy/models/user.dart';
import 'package:study_buddy/repositories/database_repository.dart';

class MockDatabaseService implements DatabaseRepository {
  final String myuid;
  MockDatabaseService({@required this.myuid}) : assert(myuid != null);

  static final List<CardEntity> cardEntities = [
    CardEntity(
        front: 'Amazon SNS',
        back: "What is sns provide a definition",
        me: "This is me"),
    CardEntity(
        front: 'Dynamo DB',
        back: "It is a serverless DB",
        me: "This is a test me"),
    CardEntity(front: 'AWS S3', back: "Storage service", me: "Another one"),
  ];

  static final List<Deck> myDecks = [
    Deck(deckName: 'Deck1', lastCreated: "17 August 2020", cards: cardEntities),
    Deck(deckName: 'Deck2', lastCreated: "17 August 2020", cards: cardEntities),
    Deck(deckName: 'Deck3', lastCreated: "9 December 2020", cards: []),
    Deck(deckName: 'Deck1', lastCreated: "17 August 2020", cards: []),
    Deck(deckName: 'Deck3', lastCreated: "9 December 2020", cards: []),
  ];

  // updates users data in the database
  @override
  Future<void> updateUserData({
    String username,
    String email,
    bool challenge,
  }) async {
    return null;
  }

  // create new deck
  @override
  Future<void> createNewDeck(String deckName, {List<CardEntity> cards}) async {
    myDecks
        .add(Deck(deckName: deckName, lastCreated: 'New Date', cards: cards));
    return myDecks;
  }

  // return current user stream
  Stream<User> myUserStream() async* {
    await Future.delayed(Duration(seconds: 1));
    yield User(uid: "user-klue");
  }

  Stream<List<Deck>> listOfDecksStream() async* {
    await Future.delayed(Duration(seconds: 1));
    yield myDecks;
  }

  // Single Card stream
  Stream<CardEntity> cardsStream() async* {
    await Future.delayed(Duration(seconds: 1));
    yield CardEntity(
        front: "What is dynamo db",
        back: "Its is something",
        me: "my definition");
  }

// gets all the user from the database
  @override
  Stream<User> get userData {
    try {
      return myUserStream();
    } catch (e) {
      print("Error from user stream : $e");
      return null;
    }
  }

  @override
  Future<void> deleteDeck({String id}) async {
    return null;
  }

  @override
  Stream<List<Deck>> get decks {
    return listOfDecksStream().asBroadcastStream();
  }

  @override
  String toString() => 'MockDatabaseService(uid: $uid)';

  @override
  String get uid => myuid;

  @override
  Stream<CardEntity> get singleCard => cardsStream().asBroadcastStream();
}
