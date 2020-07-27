import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:study_buddy/failures/failures.dart';
import 'package:study_buddy/models/card.dart';
import 'package:study_buddy/models/deck.dart';
import 'package:study_buddy/models/user.dart';
import 'package:study_buddy/repositories/database_repository.dart';

class FakeClient {
  // Firebase
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

  final List<Deck> myDecks = [
    Deck(deckName: 'Deck1', lastCreated: "17 August 2020", cards: cardEntities),
    Deck(deckName: 'Deck2', lastCreated: "17 August 2020", cards: cardEntities),
    Deck(deckName: 'Deck3', lastCreated: "9 December 2020", cards: []),
    Deck(deckName: 'Deck1', lastCreated: "17 August 2020", cards: []),
    Deck(deckName: 'Deck3', lastCreated: "9 December 2020", cards: []),
  ];

  Future<Stream<List<Deck>>> listOfDecksStream() async {
    await Future.delayed(Duration(milliseconds: 500));
    // throw SocketException('No Internet');
    // throw HttpException('404');
    return Stream.value(myDecks);
  }
}

class MockDatabaseService implements DatabaseRepository {
  final String myuid;
  FakeClient fakeClient = FakeClient();
  MockDatabaseService({@required this.myuid}) : assert(myuid != null);

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
    // myDecks
    //     .add(Deck(deckName: deckName, lastCreated: 'New Date', cards: cards));
    // return myDecks;
  }

  // return current user stream
  Stream<User> myUserStream() async* {
    await Future.delayed(Duration(seconds: 1));
    yield User(uid: "user-klue");
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
    // return myDecks.remove(deck);
  }

  // Stream<List<Deck>> myDecks = Stream.value([
  //   Deck(),
  //   Deck(),
  //   Deck()
  // ]);

  @override
  Stream<List<Deck>> get decks {
    try {
      Stream<List<Deck>> response;
      fakeClient.listOfDecksStream().then((value) => response = value);
      return response;

      // return response;
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("Couldn't find the post 😱");
    }
  }

  // @override
  // Future<List<Deck>> makeReq() async {
  //   try {
  //     final response = await fakeClient.testing();
  //     return response;
  //   } on SocketException {
  //     throw Failure('No Internet connection 😑');
  //   } on HttpException {
  //     throw Failure("Couldn't find the post 😱");
  //   }
  // }

  @override
  String toString() => 'MockDatabaseService(uid: $uid)';

  @override
  String get uid => "myuid";

  @override
  Stream<CardEntity> get singleCard => cardsStream().asBroadcastStream();
}
