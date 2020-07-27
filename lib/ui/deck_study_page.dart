import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_buddy/blocs/next_card_bloc/next_card_bloc.dart';

import 'package:study_buddy/injection.dart';
import 'package:study_buddy/blocs/card_bloc/card_entity_bloc.dart';
import 'package:study_buddy/blocs/similarity_bloc/similarity_bloc.dart';
import 'package:study_buddy/models/card.dart';
import 'package:study_buddy/models/deck.dart';
import 'package:study_buddy/models/similarity_check.dart';
import 'package:study_buddy/services/local_notification_service.dart';
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
  final NextCardBloc _nextCardBloc = locator.get<NextCardBloc>();
  SimilarityCheck checkClass = locator.get<SimilarityCheck>();
  final similarityBloc = locator.get<SimilarityBloc>();
  CardEntity currentCard;

  @override
  void initState() {
    super.initState();
    currentCard = widget.deck.getNextCard;
    _nextCardBloc.add(GetNextCardEvent(currentCard: currentCard));
  }

  @override
  void dispose() {
    similarityBloc.close();
    _cardBloc.close();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: appBar(context, title: "AWS Concepts"),
      body: BlocBuilder<NextCardBloc, NextCardState>(
          bloc: _nextCardBloc,
          builder: (context, state) {
            if (state is NextCardInitial) {
              return AnswerContainer();
            } else if (state is GetNextCardState) {
              CardEntity card = state.currentCard;
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      BlocBuilder<CardEntityBloc, CardEntityState>(
                          bloc: _cardBloc,
                          builder: (context, state) {
                            if (state is CardInitial) {
                              return AnswerContainer(
                                content: card.front,
                                cardBloc: _cardBloc,
                                deck: widget.deck,
                                nextCardBloc: _nextCardBloc,
                                similarityBloc: similarityBloc,
                                currentCard: card,
                              );
                            } else if (state is CardFrontState) {
                              return AnswerContainer(
                                content: card.front,
                                cardBloc: _cardBloc,
                                deck: widget.deck,
                                nextCardBloc: _nextCardBloc,
                                similarityBloc: similarityBloc,
                                currentCard: card,
                              );
                            } else if (state is CardBackState) {
                              return AnswerContainer(
                                content: card.back,
                                cardBloc: _cardBloc,
                                deck: widget.deck,
                                nextCardBloc: _nextCardBloc,
                                similarityBloc: similarityBloc,
                                currentCard: card,
                              );
                            } else if (state is CardMeState) {
                              return AnswerContainer(
                                content: card.me,
                                cardBloc: _cardBloc,
                                deck: widget.deck,
                                nextCardBloc: _nextCardBloc,
                                similarityBloc: similarityBloc,
                                currentCard: card,
                              );
                            }
                            return Container();
                          })
                    ]),
              );
            } else if (state is ErrorNextCardState) {
              return Text("${state.message}");
            }
            return Container();
          }),
    );
  }
}

class AnswerContainer extends StatelessWidget {
  final String content;
  final CardEntityBloc cardBloc;
  final NextCardBloc nextCardBloc;
  final SimilarityBloc similarityBloc;
  CardEntity currentCard;
  final Deck deck;
  AnswerContainer(
      {this.content,
      this.cardBloc,
      this.deck,
      this.nextCardBloc,
      this.similarityBloc,
      this.currentCard});
  final notification = locator.get<LocalNotificationService>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onLongPress: () {
            cardBloc.add(LongPressCardEvent());
          },
          onDoubleTap: () {
            cardBloc.add(DoubleTapCardEvent());
          },
          onTap: () {
            cardBloc.add(SingleTapCardEvent());
          },
          child: Container(
            alignment: Alignment.center,
            height: ScreenSize.screenHeight(context) * 0.45,
            width: ScreenSize.screenWidth(context) * 0.9,
            padding: const EdgeInsets.only(left: 10.0, top: 8.0),
            decoration: decoration,
            child: Text(content ?? "Deck is empty"),
          ),
        ),
        SizedBox(height: 30.0),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: checkSimilarityWidget(similarityBloc: similarityBloc),
        ),
        Container(
          height: 60.0,
          width: 375.0,
          decoration: decoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: TimeFrameItem(
                  icon: Icons.thumb_down,
                  label: "bad",
                  pressed: () {
                    currentCard = deck.getNextCard;
                    nextCardBloc
                        .add(GetNextCardEvent(currentCard: currentCard));
                    // notification.notification();
                  },
                ),
              ),
              Expanded(
                child: TimeFrameItem(
                  label: "again",
                  icon: Icons.star_half,
                  pressed: () {
                    notification.notification();
                  },
                ),
              ),
              Expanded(
                child: TimeFrameItem(
                  icon: Icons.thumb_up,
                  label: "good",
                  pressed: () {
                    notification.notification();
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15.0),
      ],
    );
  }
}
