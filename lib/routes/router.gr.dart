// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:study_buddy/ui/home_page.dart';
import 'package:study_buddy/ui/edit_card.dart';
import 'package:study_buddy/models/card.dart';
import 'package:study_buddy/ui/edit_deck.dart';
import 'package:study_buddy/models/deck.dart';
import 'package:study_buddy/ui/landing_page.dart';
import 'package:study_buddy/ui/create_new_card.dart';
import 'package:study_buddy/ui/create_new_deck.dart';
import 'package:study_buddy/ui/deck_study_page.dart';

abstract class Routes {
  static const homePage = '/';
  static const editCardPage = '/edit-card-page';
  static const editDeckPage = '/edit-deck-page';
  static const landingPage = '/landing-page';
  static const createNewCardPage = '/create-new-card-page';
  static const createNewDeckPage = '/create-new-deck-page';
  static const deckStudyPage = '/deck-study-page';
  static const all = {
    homePage,
    editCardPage,
    editDeckPage,
    landingPage,
    createNewCardPage,
    createNewDeckPage,
    deckStudyPage,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.homePage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomePage(),
          settings: settings,
        );
      case Routes.editCardPage:
        if (hasInvalidArgs<EditCardPageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<EditCardPageArguments>(args);
        }
        final typedArgs = args as EditCardPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => EditCardPage(cardEntity: typedArgs.cardEntity),
          settings: settings,
        );
      case Routes.editDeckPage:
        if (hasInvalidArgs<EditDeckPageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<EditDeckPageArguments>(args);
        }
        final typedArgs = args as EditDeckPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => EditDeckPage(deck: typedArgs.deck),
          settings: settings,
        );
      case Routes.landingPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => LandingPage(),
          settings: settings,
        );
      case Routes.createNewCardPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => CreateNewCardPage(),
          settings: settings,
        );
      case Routes.createNewDeckPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => CreateNewDeckPage(),
          settings: settings,
        );
      case Routes.deckStudyPage:
        if (hasInvalidArgs<DeckStudyPageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<DeckStudyPageArguments>(args);
        }
        final typedArgs = args as DeckStudyPageArguments;
        return PageRouteBuilder<dynamic>(
          pageBuilder: (context, animation, secondaryAnimation) =>
              DeckStudyPage(deck: typedArgs.deck),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.zoomIn,
          transitionDuration: const Duration(milliseconds: 200),
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//EditCardPage arguments holder class
class EditCardPageArguments {
  final CardEntity cardEntity;
  EditCardPageArguments({@required this.cardEntity});
}

//EditDeckPage arguments holder class
class EditDeckPageArguments {
  final Deck deck;
  EditDeckPageArguments({@required this.deck});
}

//DeckStudyView arguments holder class
class DeckStudyPageArguments {
  final Deck deck;
  DeckStudyPageArguments({@required this.deck});
}
