import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:study_buddy/failures/failures.dart';
import 'package:study_buddy/models/deck.dart';
import 'package:study_buddy/repositories/database_repository.dart';

part 'deck_event.dart';
part 'deck_state.dart';

class DeckBloc extends Bloc<DeckEvent, DeckState> {
  final DatabaseRepository repository;

  DeckBloc({@required this.repository}) : assert(repository != null);
  @override
  DeckState get initialState => DeckInitial();
  List<Deck> lData;
  var fError;

  @override
  Stream<DeckState> mapEventToState(
    DeckEvent event,
  ) async* {
    if (event is FetchDeckEvent) {
      yield LoadingDeckState();

      final lDecks = repository.decks;
      print(lDecks);

      lDecks.listen((data) {
        print("I have data $data");
        lData = data;
      }).onError((f) async* {
        print("There is an error $f");
        fError = f;
      });
      yield LoadedDeckState(decks: lData);
      yield ErrorDeckState(failure: Failure(fError.toString()));
    }
  }
}
