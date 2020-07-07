import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:study_buddy/models/card.dart';

class Deck {
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
    if (_currentCardIndex >= length) {
      return null;
      //ards[_currentCardIndex - 1]; // no question left

    }
    return cards[_currentCardIndex];
  }

  @override
  String toString() {
    return 'Deck(deckName: $deckName, cards: $cards, lastCreated: $lastCreated, tags: $tags)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Deck &&
        o.deckName == deckName &&
        listEquals(o.cards, cards) &&
        o.lastCreated == lastCreated &&
        listEquals(o.tags, tags);
  }

  @override
  int get hashCode {
    return deckName.hashCode ^
        cards.hashCode ^
        lastCreated.hashCode ^
        tags.hashCode;
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
}
