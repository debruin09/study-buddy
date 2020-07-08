import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:study_buddy/models/deck.dart';
import 'package:study_buddy/repositories/database_repository.dart';

part 'deck_event.dart';
part 'deck_state.dart';

class DeckBloc extends Bloc<DeckEvent, DeckState> {
  final DatabaseRepository repository;

  DeckBloc({@required this.repository}) : assert(repository != null);
  @override
  DeckState get initialState => DeckInitial();

  @override
  Stream<DeckState> mapEventToState(
    DeckEvent event,
  ) async* {
    if (event is FetchDeckEvent) {
      yield LoadingDeckState();
      try {
        final decks = repository.decks;
        yield LoadedDeckState(decks: decks);
      } catch (e) {
        yield ErrorDeckState(errorMessage: e.message);
      }
    }
  }
}
