import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_buddy/repositories/database_repository.dart';

part 'card_entity_event.dart';
part 'card_entity_state.dart';

class CardEntityBloc extends Bloc<CardEnitytEvent, CardEntityState> {
  final DatabaseRepository repository;
  CardEntityBloc({@required this.repository}) : assert(repository != null);
  @override
  CardEntityState get initialState => CardInitial();

  @override
  Future<void> close() {
    return super.close();
  }

  @override
  Stream<CardEntityState> mapEventToState(
    CardEnitytEvent event,
  ) async* {
    // if (event is FetchingCardEvent) {
    //   yield CardLoadingState();
    //   try {
    //     final cards = repository.cards;
    //     yield CardLoadedState(cards: cards);
    //   } catch (e) {
    //     yield CardErrorState(message: e.message.toString());
    //   }
    // }

    if (event is LongPressCardEvent) {
      yield CardFrontState();
    }

    if (event is SingleTapCardEvent) {
      yield CardBackState();
    }

    if (event is DoubleTapCardEvent) {
      yield CardMeState();
    }
  }
}
