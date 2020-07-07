import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

import 'package:study_buddy/injection.dart';
import 'package:study_buddy/blocs/card_bloc/card_entity_bloc.dart';
import 'package:study_buddy/blocs/deck_bloc/deck_bloc.dart';
import 'package:study_buddy/blocs/similarity_bloc/similarity_bloc.dart';
import 'package:study_buddy/models/card.dart';
import 'package:study_buddy/models/deck.dart';
import 'package:study_buddy/models/similarity_check.dart';
import 'package:study_buddy/ui/shared/constants.dart';
import 'package:study_buddy/ui/shared_widgets/shared_widgets.dart';

class DeckStudyPage extends StatefulWidget {
  final Deck deck;
  DeckStudyPage({@required this.deck});
  @override
  _DeckStudyPageState createState() => _DeckStudyPageState();
}

class _DeckStudyPageState extends State<DeckStudyPage> {
  final CardEntityBloc _cardBloc = locator.get<CardEntityBloc>();
  final DeckBloc _deckBloc = locator.get<DeckBloc>();
  SimilarityCheck checkClass = locator.get<SimilarityCheck>();
  final similarityBloc = locator.get<SimilarityBloc>();
  CardEntity currentCard;

  @override
  void initState() {
    super.initState();
    currentCard = widget.deck.getNextCard;
    _deckBloc.add(NextCardEvent(currentCard: currentCard));
  }

  @override
  void dispose() {
    similarityBloc.close();
    super.dispose();
  }

  // Widget cardContainer(context, {String content}) {
  //   // double degToRad(deg) {
  //   //   return deg * (180.0 / math.pi);
  //   // }

  //   return Column(
  //     children: <Widget>[
  //       GestureDetector(
  //         onDoubleTap: () {
  //           _cardBloc.add(DoubleTapCardEvent());
  //         },
  //         onTap: () {
  //           _cardBloc.add(SingleTapCardEvent());
  //         },
  //         child: AnimatedContainer(
  //           duration: Duration(milliseconds: 300),
  //           transform: Matrix4.identity()..rotateX(2 * math.pi * 80.0),
  //           alignment: Alignment.center,
  //           height: ScreenSize.screenHeight(context) * 0.45,
  //           width: ScreenSize.screenWidth(context) * 0.9,
  //           padding: const EdgeInsets.only(left: 10.0, top: 8.0),
  //           decoration: decoration,
  //           child: Text(content),
  //         ),
  //       ),
  //       SizedBox(height: 30.0),
  //       difficultyBar(context),
  //       SizedBox(height: 15.0),
  //     ],
  //   );
  // }

  Widget answerContainer(context, {String content}) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onLongPress: () {
            _cardBloc.add(LongPressCardEvent());
          },
          onDoubleTap: () {
            _cardBloc.add(DoubleTapCardEvent());
          },
          onTap: () {
            _cardBloc.add(SingleTapCardEvent());
          },
          child: Container(
            alignment: Alignment.center,
            height: ScreenSize.screenHeight(context) * 0.45,
            width: ScreenSize.screenWidth(context) * 0.9,
            padding: const EdgeInsets.only(left: 10.0, top: 8.0),
            decoration: decoration,
            child: Text(content),
          ),
        ),
        SizedBox(height: 30.0),
        timeFrameWidget(
            deck: widget.deck,
            deckBloc: _deckBloc,
            check: checkClass.check,
            similarityBloc: similarityBloc),
        SizedBox(height: 15.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cards = widget.deck.cards;
    final firstCard = cards[0];

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: appBar(context, title: "AWS Concepts"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<CardEntityBloc, CardEntityState>(
                bloc: _cardBloc,
                builder: (context, state) {
                  if (state is CardInitial) {
                    return answerContainer(context, content: firstCard.front);
                  } else if (state is CardFrontState) {
                    return answerContainer(context, content: firstCard.front);
                  } else if (state is CardBackState) {
                    return answerContainer(context, content: firstCard.back);
                  } else if (state is CardMeState) {
                    return answerContainer(context, content: firstCard.me);
                  }
                  return Container();
                }),
          ],
        ),
      ),
    );
  }
}
