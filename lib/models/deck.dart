import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:study_buddy/models/card.dart';

class Deck extends Equatable {
  String deckName;
  List<CardEntity> cards = [];
  String lastCreated;
  List<String> tags = [];
  int _currentCardIndex = -1;

  Deck({
    this.deckName,
    this.cards,
    this.lastCreated,
    this.tags,
  });

  List<CardEntity> get getCards => cards;
  int get length => cards.length;
  int get cardNumber => _currentCardIndex + 1;

  CardEntity get getNextCard {
    _currentCardIndex++;
    if (cards.isEmpty) {
      return CardEntity(back: "", front: "", tags: [], me: "");
    } else if (_currentCardIndex >= length) {
      return cards.last; // no card left return last card
    }
    return cards[_currentCardIndex];
  }

  @override
  String toString() {
    return 'Deck(deckName: $deckName, cards: $cards, lastCreated: $lastCreated, tags: $tags)';
  }

  Map<String, dynamic> toMap() {
    return {
      'deckName': deckName,
      'cards': cards?.map((x) => x?.toMap())?.toList(),
      'lastCreated': lastCreated,
      'tags': tags,
    };
  }

  static Deck fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Deck(
      deckName: map['deckName'],
      cards: List<CardEntity>.from(
          map['cards']?.map((x) => CardEntity.fromMap(x))),
      lastCreated: map['lastCreated'],
      tags: List<String>.from(map['tags']),
    );
  }

  String toJson() => json.encode(toMap());

  static Deck fromJson(String source) => fromMap(json.decode(source));

  @override
  List<Object> get props => [deckName, cards, lastCreated, tags];
}
