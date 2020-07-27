part of 'next_card_bloc.dart';

@immutable
abstract class NextCardState {}

class NextCardInitial extends NextCardState {}

class GetNextCardState extends NextCardState {
  final CardEntity currentCard;
  GetNextCardState({@required this.currentCard}) : assert(currentCard != null);
}

class ErrorNextCardState extends NextCardState {
  final String message;
  ErrorNextCardState({@required this.message});
}
