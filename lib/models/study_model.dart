import 'package:study_buddy/models/card.dart';

class StudyModel {
  bool cardDone = false;
  bool uncomplete = false;
  int uncompleteCount = 0;

  CardEntity navigateToNextCard(
      List<CardEntity> cards, CardEntity currentCard) {
    if (cards.isEmpty) {
      return null;
    }
    int i = cards.indexOf(currentCard);
    if (i < cards.length) {
      return cards[i + 1];
    }
    return null;
  }
}
