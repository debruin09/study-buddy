import 'package:flutter/foundation.dart';
import 'package:study_buddy/models/card.dart';
import 'package:study_buddy/models/deck.dart';
import 'package:study_buddy/models/user.dart';

abstract class DatabaseRepository {
  final String uid = '';

  Future<void> updateUserData({
    @required String username,
    String email,
    bool challenge,
  });

  Future<void> createNewDeck(String deckName, {List<CardEntity> cards});
  Future<void> deleteDeck({@required String id});
  Stream<User> get userData;
  Stream<List<Deck>> get decks;
  Stream<CardEntity> get singleCard;
}
