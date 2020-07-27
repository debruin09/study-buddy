// import 'package:dartz/dartz.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_buddy/failures/failures.dart';
import 'package:study_buddy/injection.dart';
import 'package:study_buddy/blocs/card_bloc/card_entity_bloc.dart';
import 'package:study_buddy/blocs/deck_bloc/deck_bloc.dart';
import 'package:study_buddy/models/deck.dart';
import 'package:study_buddy/services/local_notification_service.dart';
import 'package:study_buddy/ui/navigations/navigations.dart';
import 'package:study_buddy/ui/shared/constants.dart';
import 'package:study_buddy/ui/shared/theme.dart';
import 'package:study_buddy/ui/shared_widgets/shared_widgets.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final DeckBloc _deckBloc = locator.get<DeckBloc>();
//   final CardEntityBloc _cardBloc = locator.get<CardEntityBloc>();
//   final LocalNotificationService _locNotification =
//       locator.get<LocalNotificationService>();

//   @override
//   void initState() {
//     _deckBloc.add(FetchDeckEvent());
//     super.initState();
//     _locNotification.initializing();
//   }

//   @override
//   void dispose() {
//     _deckBloc.close();
//     _cardBloc
//         .close(); // Rule of thumb: never close a object outside the widget that created it
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("Building Home Page");
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppTheme.themeColor,
//         body: CustomScrollView(
//           slivers: <Widget>[
//             SliverAppBar(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.vertical(
//                   bottom: Radius.circular(20),
//                 ),
//               ),
//               backgroundColor: AppTheme.cardColor,
//               centerTitle: true,
//               floating: true,
//               pinned: true,
//               elevation: 0.0,
//               actionsIconTheme: Theme.of(context).iconTheme,
//               titleSpacing: 2.0,
//               expandedHeight: 150.0,
//               leading: Icon(
//                 Icons.menu,
//                 color: Theme.of(context).iconTheme.color,
//               ),
//               actions: <Widget>[
//                 IconButton(
//                     icon: Icon(Icons.add),
//                     onPressed: () {
//                       navigateToCreateNewDeckPage();
//                     })
//               ],
//               title: Padding(
//                 padding: const EdgeInsets.only(bottom: 8.0, top: 20.0),
//                 child: Text(
//                   "Home",
//                   style: Theme.of(context).textTheme.bodyText1,
//                 ),
//               ),
//               flexibleSpace: FlexibleSpaceBar(
//                 collapseMode: CollapseMode.pin,
//                 titlePadding: EdgeInsets.only(
//                   top: 40.0,
//                 ),
//                 centerTitle: true,
//                 title: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 20.0, vertical: 20.0),
//                   child: searchBar(context),
//                 ),
//               ),
//             ),
//             SliverFillRemaining(
//               child: SingleChildScrollView(
//                 child: containerWidget(
//                   body: BlocBuilder<DeckBloc, DeckState>(
//                     bloc: _deckBloc,
//                     builder: (context, state) {
//                       if (state is LoadingDeckState) {
//                         return loadingWidget();
//                       } else if (state is LoadedDeckState) {
//                         final deckStream = state.decks;
//                         return StreamBuilder<Either<Failure, List<Deck>>>(
//                             stream: deckStream.asBroadcastStream(),
//                             builder: (context, snapshot) {
//                               if (snapshot.hasData) {
//                                 final decks = snapshot.data;
//                                 return Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 20.0),
//                                     child: decks.fold(
//                                       (l) => Center(
//                                         child: Text(l.message),
//                                       ),
//                                       (r) => Wrap(
//                                         runSpacing: 20.0,
//                                         spacing: 20.0,
//                                         alignment: WrapAlignment.start,
//                                         direction: Axis.horizontal,
//                                         children: r
//                                             .map((deck) => DeckCard(
//                                                   deck: deck,
//                                                   locNotification:
//                                                       _locNotification,
//                                                 ))
//                                             .toList(),
//                                       ),
//                                     ));
//                               }
//                               return loadingWidget();
//                             });
//                       } else if (state is ErrorDeckState) {
//                         return Center(
//                           child: Text(state.errorMessage.toString()),
//                         );
//                       }
//                       return Container(); // TODO: Find out which state this is
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

Widget containerWidget({Widget body}) {
  return Column(children: <Widget>[
    SizedBox(height: 20.0),
    SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: body,
      ),
    )
  ]);
}

searchBar(context) {
  return Container(
    width: ScreenSize.screenWidth(context) * 0.7,
    height: 30.0,
    decoration: decoration.copyWith(
        color: Colors.white, borderRadius: BorderRadius.circular(10)),
    child: TextFormField(
      decoration: InputDecoration(
        hintStyle: TextStyle(fontSize: 10.0),
        contentPadding: EdgeInsets.only(left: 20.0, bottom: 18.0),
        border: InputBorder.none,
        hintText: "Search for decks, cards and tags",
        suffixIcon: IconButton(
            icon: Icon(
              Icons.search,
              size: 17.0,
            ),
            onPressed: () {
              // navigateToCreateNewDeckPage();
              print("Searched something");
            }),
      ),
    ),
  );
}

class DeckCard extends StatelessWidget {
  final locNotification;
  final Deck deck;

  DeckCard({@required this.deck, this.locNotification});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToDeckStudyPage(deck);
      },
      child: Container(
        height: ScreenSize.screenHeight(context) * 0.4,
        width: ScreenSize.screenWidth(context) * 0.8,
        padding: const EdgeInsets.only(
          left: 20.0,
        ),
        decoration: decoration,
        child: Container(
          height: ScreenSize.screenHeight(context) * 0.4,
          width: ScreenSize.screenWidth(context) * 0.8,
          padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 5.0),
          decoration: decoration.copyWith(color: AppTheme.cardSecColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 3,
                      child: Text(
                        "${deck.deckName}",
                        style: Theme.of(context).textTheme.headline6,
                      )),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: () {
                          navigateToEditDeckPage(deck);
                        },
                        icon: Icon(Icons.edit),
                        color: Colors.black.withOpacity(0.6)),
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Text(
                "${deck.lastCreated}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.black38,
                    );
                  },
                  shrinkWrap: true,
                  itemCount: deck.cards.length ?? 0,
                  itemBuilder: (context, index) {
                    return deck.cards.isNotEmpty
                        ? Text(deck.cards[index].front,
                            style: Theme.of(context).textTheme.bodyText2)
                        : Text("");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final DeckBloc _deckBloc = locator.get<DeckBloc>();
  final CardEntityBloc _cardBloc = locator.get<CardEntityBloc>();
  final LocalNotificationService _locNotification =
      locator.get<LocalNotificationService>();

  @override
  Widget build(BuildContext context) {
    print("Building Home Page");
    _deckBloc.add(FetchDeckEvent());
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.themeColor,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              backgroundColor: AppTheme.cardColor,
              centerTitle: true,
              floating: true,
              pinned: true,
              elevation: 0.0,
              actionsIconTheme: Theme.of(context).iconTheme,
              titleSpacing: 2.0,
              expandedHeight: 150.0,
              leading: Icon(
                Icons.menu,
                color: Theme.of(context).iconTheme.color,
              ),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      navigateToCreateNewDeckPage();
                    })
              ],
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 20.0),
                child: Text(
                  "Home",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                titlePadding: EdgeInsets.only(
                  top: 40.0,
                ),
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: searchBar(context),
                ),
              ),
            ),
            SliverFillRemaining(
              child: SingleChildScrollView(
                child: containerWidget(
                  body: BlocBuilder<DeckBloc, DeckState>(
                    bloc: _deckBloc,
                    builder: (context, state) {
                      if (state is LoadingDeckState) {
                        return loadingWidget();
                      } else if (state is LoadedDeckState) {
                        final data = state.decks;

                        return Wrap(
                          runSpacing: 20.0,
                          spacing: 20.0,
                          alignment: WrapAlignment.start,
                          direction: Axis.horizontal,
                          children: data
                              .map((deck) => DeckCard(
                                    deck: deck,
                                    locNotification: _locNotification,
                                  ))
                              .toList(),
                        );
                      } else if (state is ErrorDeckState) {
                        return Center(
                          child: Text(state.failure.toString()),
                        );
                      }
                      return Container(); // TODO: Find out which state this is
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
