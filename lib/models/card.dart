import 'dart:convert';

import 'package:flutter/foundation.dart';

class CardEntity {
  String front;
  String back;
  String me;
  String difficulty;
  String dateCreated = DateTime.now().toIso8601String().toString();
  bool done = false;
  List<String> tags;

  CardEntity({
    this.front,
    this.back,
    this.me,
    this.difficulty,
    this.done,
    this.tags,
  });

  CardEntity copyWith({
    String front,
    String back,
    String me,
    String difficulty,
    bool done,
    List<String> tags,
  }) {
    return CardEntity(
      front: front ?? this.front,
      back: back ?? this.back,
      me: me ?? this.me,
      difficulty: difficulty ?? this.difficulty,
      done: done ?? this.done,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'front': front,
      'back': back,
      'me': me,
      'difficulty': difficulty,
      'done': done,
      'tags': tags,
    };
  }

  static CardEntity fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CardEntity(
      front: map['front'],
      back: map['back'],
      me: map['me'],
      difficulty: map['difficulty'],
      done: map['done'],
      tags: List<String>.from(map['tags']),
    );
  }

  String toJson() => json.encode(toMap());

  static CardEntity fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'CardEntity(front: $front, back: $back, me: $me, difficulty: $difficulty, done: $done, tags: $tags)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CardEntity &&
        o.front == front &&
        o.back == back &&
        o.me == me &&
        o.difficulty == difficulty &&
        o.done == done &&
        listEquals(o.tags, tags);
  }

  @override
  int get hashCode {
    return front.hashCode ^
        back.hashCode ^
        me.hashCode ^
        difficulty.hashCode ^
        done.hashCode ^
        tags.hashCode;
  }
}
