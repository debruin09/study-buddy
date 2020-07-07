part of 'deck_bloc.dart';

abstract class DeckState extends Equatable {
  const DeckState();
  @override
  List<Object> get props => [];
}

class DeckInitial extends DeckState {}

class LoadingDeckState extends DeckState {}

class LoadedDeckState extends DeckState {
  final Stream<List<Deck>> decks;
  LoadedDeckState({@required this.decks}) : assert(decks != null);
}

class ErrorDeckState extends DeckState {
  final String errorMessage;

  ErrorDeckState({@required this.errorMessage}) : assert(errorMessage != null);
  @override
  String toString() => 'ErrorDeckState { errorMessage: $errorMessage }';
}

class NextCardState extends DeckState {}
