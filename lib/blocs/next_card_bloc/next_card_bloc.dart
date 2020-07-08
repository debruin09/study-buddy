import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_buddy/models/card.dart';
import 'package:study_buddy/repositories/database_repository.dart';

part 'next_card_event.dart';
part 'next_card_state.dart';

class NextCardBloc extends Bloc<NextCardEvent, NextCardState> {
  final DatabaseRepository databaseRepository;
  bool isDeckEmpty = true;

  NextCardBloc({@required this.databaseRepository})
      : assert(databaseRepository != null);
  @override
  Stream<NextCardState> mapEventToState(
    NextCardEvent event,
  ) async* {
    if (event is GetNextCardEvent) {
      databaseRepository.decks.map((event) => event.map((e) {
            isDeckEmpty = e.cards.isEmpty;
            print("This is is deck empty: $isDeckEmpty");
          }));
      if (isDeckEmpty == true) {
        yield NextCardInitial();
      }
      yield GetNextCardState(currentCard: event.currentCard);
    }
  }

  @override
  NextCardState get initialState => NextCardInitial();
}
