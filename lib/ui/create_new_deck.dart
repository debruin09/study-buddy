import 'package:flutter/material.dart';
import 'package:study_buddy/ui/navigations/navigations.dart';
import 'package:study_buddy/ui/shared/constants.dart';
import 'package:study_buddy/ui/shared/theme.dart';
import 'package:study_buddy/ui/shared_widgets/shared_widgets.dart';

class CreateNewDeckPage extends StatefulWidget {
  @override
  _CreateNewDeckPageState createState() => _CreateNewDeckPageState();
}

class _CreateNewDeckPageState extends State<CreateNewDeckPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.themeColor,
      appBar: appBar(context, title: 'Create New Deck'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextFormField(
              decoration: inputDecoration.copyWith(hintText: 'Deck name'),
            ),
          ],
        ),
      ),
      //TODO: CREATE A NEW DECK
      floatingActionButton: fab(onPressed: () {
        navigateToCreateNewCardPage();
      }),
    );
  }
}
