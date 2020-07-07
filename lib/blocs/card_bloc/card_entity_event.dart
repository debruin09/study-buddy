part of 'card_entity_bloc.dart';

@immutable
abstract class CardEnitytEvent {}

class FetchingCardEvent extends CardEnitytEvent {}

class SingleTapCardEvent extends CardEnitytEvent {
  @override
  String toString() => 'SingleTapCardEvent { single tap }';
}

class OnLoadCardEvent extends CardEnitytEvent {
  @override
  String toString() => 'OnLoadCardEvent { trigger onload }';
}

class DoubleTapCardEvent extends CardEnitytEvent {
  @override
  String toString() => 'DoubleTapCardEvent { double tap }';
}

class LongPressCardEvent extends CardEnitytEvent {
  @override
  String toString() => 'LongPressCardEvent { long tap }';
}
