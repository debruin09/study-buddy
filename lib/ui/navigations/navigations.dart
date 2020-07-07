import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy/models/card.dart';
import 'package:study_buddy/models/deck.dart';
import 'package:study_buddy/routes/router.gr.dart';

// Navigation fuctions
void navigateToHomePage() {
  ExtendedNavigator.ofRouter<Router>().pushNamed(Routes.homePage);
}

void navigateToDeckStudyPage(Deck deck) {
  ExtendedNavigator.ofRouter<Router>().pushNamedAndRemoveUntil(
      Routes.deckStudyPage, ModalRoute.withName("/"),
      arguments: DeckStudyPageArguments(deck: deck));
}

void navigateToCreateNewDeckPage() {
  ExtendedNavigator.ofRouter<Router>().pushNamed(Routes.createNewDeckPage);
}

void navigateToCreateNewCardPage() {
  ExtendedNavigator.ofRouter<Router>().pushNamed(Routes.createNewCardPage);
}

void navigateToEditDeckPage(Deck deck) {
  ExtendedNavigator.ofRouter<Router>().pushNamed(Routes.editDeckPage,
      arguments: EditDeckPageArguments(deck: deck));
}

void navigateToEditCardPage(CardEntity card) {
  ExtendedNavigator.ofRouter<Router>().pushNamed(Routes.editCardPage,
      arguments: EditCardPageArguments(cardEntity: card));
}
