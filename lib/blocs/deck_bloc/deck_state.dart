part of 'deck_bloc.dart';

abstract class DeckState extends Equatable {
  const DeckState();
  @override
  List<Object> get props => [];
}

class DeckInitial extends DeckState {}

class LoadingDeckState extends DeckState {}

class LoadedDeckState extends DeckState {
  final List<Deck> decks;
  LoadedDeckState({@required this.decks}) : assert(decks != null);
}

class ErrorDeckState extends DeckState {
  final Failure failure;

  ErrorDeckState({@required this.failure}) : assert(failure != null);
  @override
  String toString() => 'ErrorDeckState { errorMessage: $failure }';
}
