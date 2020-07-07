part of 'card_entity_bloc.dart';

@immutable
abstract class CardEntityState {}

class CardInitial extends CardEntityState {}

class CardErrorState extends CardEntityState {
  final String message;

  CardErrorState({@required this.message}) : assert(message != null);
}

class CardFrontState extends CardEntityState {}

class CardBackState extends CardEntityState {}

class CardMeState extends CardEntityState {}
