part of 'deck_bloc.dart';

abstract class DeckEvent extends Equatable {
  const DeckEvent();
  @override
  List<Object> get props => [];
}

class FetchDeckEvent extends DeckEvent {
  @override
  String toString() => 'Fetching data event triggered';
}

class NextCardEvent extends DeckEvent {
  final CardEntity currentCard;
  NextCardEvent({
    @required this.currentCard,
  });
}
