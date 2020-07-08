part of 'next_card_bloc.dart';

@immutable
abstract class NextCardEvent {}

class GetNextCardEvent extends NextCardEvent {
  final CardEntity currentCard;
  GetNextCardEvent({@required this.currentCard});
}
