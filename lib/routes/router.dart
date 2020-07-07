import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:study_buddy/ui/create_new_card.dart';
import 'package:study_buddy/ui/create_new_deck.dart';
import 'package:study_buddy/ui/deck_study_page.dart';
import 'package:study_buddy/ui/edit_card.dart';
import 'package:study_buddy/ui/edit_deck.dart';
import 'package:study_buddy/ui/home_page.dart';

import 'package:study_buddy/ui/landing_page.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  HomePage homePage;
  EditCardPage editCardPage;
  EditDeckPage editDeckPage;
  LandingPage landingPage;
  CreateNewCardPage createNewCardPage;
  CreateNewDeckPage createNewDeckPage;
  @CustomRoute(
      transitionsBuilder: TransitionsBuilders.zoomIn,
      durationInMilliseconds: 200)
  DeckStudyPage deckStudyPage;
}
