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
  String err;

  NextCardBloc({@required this.databaseRepository})
      : assert(databaseRepository != null);
  @override
  Stream<NextCardState> mapEventToState(
    NextCardEvent event,
  ) async* {
    if (event is GetNextCardEvent) {
      try {
        yield GetNextCardState(currentCard: event.currentCard);
      } catch (e) {
        databaseRepository.decks.handleError((error) => err = error);
        yield ErrorNextCardState(message: "$e and $err");
      }

      // if (isDeckEmpty == true) {
      //   yield NextCardInitial();
      // }

    }
  }

  @override
  NextCardState get initialState => NextCardInitial();
}
