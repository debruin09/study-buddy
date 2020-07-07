import 'package:flutter/material.dart';
import 'package:study_buddy/models/deck.dart';
import 'package:study_buddy/ui/navigations/navigations.dart';
import 'package:study_buddy/ui/shared/constants.dart';
import 'package:study_buddy/ui/shared/theme.dart';
import 'package:study_buddy/ui/shared_widgets/shared_widgets.dart';

class EditDeckPage extends StatefulWidget {
  final Deck deck;
  EditDeckPage({@required this.deck});
  @override
  _EditDeckPageState createState() => _EditDeckPageState();
}

class _EditDeckPageState extends State<EditDeckPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: appBar(
        context,
        title: "Edit Deck",
        trailing: FlatButton.icon(
          onPressed: () {
            navigateToEditDeckPage(widget.deck);
          },
          icon: Icon(
            Icons.mode_edit,
            color: AppTheme.iconColor,
          ),
          label: Text(""),
        ),
      ),
      body: formWidgetBuilder(
        formItems: deckFormItems(context, widget.deck),
      ),
      floatingActionButton: fab(onPressed: () {
        navigateToCreateNewCardPage();
      }),
    );
  }
}

// return list of cards containing in the deck
Widget deckCardsBuilder(BuildContext context, Deck deck) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: deck.cards.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: CardItem(card: deck.cards[index]),
        );
      });
}

// Form widgets for the deck
List<Widget> deckFormItems(BuildContext context, Deck deck) {
  return [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 5.0),
      child: TextFormField(
        decoration: inputDecoration.copyWith(hintText: "Edit deck name"),
      ),
    ),
    tagWidget(),
    SizedBox(
      height: 10.0,
    ),
    deckCardsBuilder(context, deck),
  ];
}
