import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tagging/flutter_tagging.dart';

import 'package:study_buddy/blocs/similarity_bloc/similarity_bloc.dart';
import 'package:study_buddy/injection.dart';
import 'package:study_buddy/models/card.dart';
import 'package:study_buddy/models/tag_entity.dart';
import 'package:study_buddy/repositories/tag_repository.dart';
import 'package:study_buddy/services/local_notification_service.dart';
import 'package:study_buddy/ui/navigations/navigations.dart';
import 'package:study_buddy/ui/shared/constants.dart';
import 'package:study_buddy/ui/shared/theme.dart';

Widget appBar(
  context, {
  @required String title,
  Widget leading,
  Widget trailing,
}) {
  return AppBar(
    elevation: 0.0,
    titleSpacing: 5.0,
    iconTheme: Theme.of(context).appBarTheme.iconTheme,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    ),
    leading: leading,
    textTheme: Theme.of(context).appBarTheme.textTheme,
    title: Text(
      title,
      style: TextStyle(fontSize: 20.0),
    ),
    centerTitle: true,
    actions: <Widget>[trailing ?? SizedBox(width: 2.0)],
  );
}

Widget loadingWidget() {
  return Center(
      child: CircularProgressIndicator(
    backgroundColor: Colors.greenAccent,
  ));
}

Widget fab({Function onPressed}) {
  return FloatingActionButton(
    backgroundColor: AppTheme.iconColor,
    onPressed: onPressed,
    child: Icon(Icons.add, color: Colors.white),
  );
}

// Form Widget
Widget formWidgetBuilder({List<Widget> formItems}) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: formItems,
          ),
        ),
      ),
    ),
  );
}

// Form Button
class FormButton extends StatelessWidget {
  final VoidCallback callback;
  FormButton({
    Key key,
    this.callback,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50.0,
      onPressed: callback,
      color: AppTheme.iconColor,
      child: Text(
        "edit",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

// TAG WIDGET
Widget tagWidget() {
  final tagService = locator.get<TagRepository>();
  final List<TagEntity> selectedTags = [];
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: FlutterTagging<TagEntity>(
      initialItems: selectedTags,
      textFieldConfiguration: TextFieldConfiguration(
          decoration: inputDecoration.copyWith(hintText: 'Enter tags')),
      findSuggestions: tagService.getTags,
      additionCallback: (value) {
        return TagEntity(
          tag: value,
        );
      },
      onAdded: (language) {
        return TagEntity(tag: language.tag);
      },
      configureSuggestion: (t) {
        return SuggestionConfiguration(
          title: Text(t.tag),
          additionWidget: Chip(
            avatar: Icon(
              Icons.add_circle,
              color: Colors.white,
            ),
            label: Text('Add New Tag'),
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
            ),
            backgroundColor: AppTheme.iconColor,
          ),
        );
      },
      configureChip: (t) {
        return ChipConfiguration(
          label: Text(t.tag),
          backgroundColor: AppTheme.iconColor,
          labelStyle: TextStyle(color: Colors.white),
          deleteIconColor: Colors.white,
        );
      },
      // onChanged: () {},
    ),
  );
}

// FORM ITEMS
final List<Widget> cardFormItems = [
  TextFormField(
      decoration: inputDecoration.copyWith(
    hintText: 'Title',
  )),
  SizedBox(height: 10.0),
  tagWidget(),
  SizedBox(height: 10.0),
  TextFormField(
      maxLines: 10, decoration: inputDecoration.copyWith(hintText: 'Front')),
  SizedBox(height: 10.0),
  TextFormField(
      maxLines: 10, decoration: inputDecoration.copyWith(hintText: 'Back')),
  SizedBox(height: 10.0),
  TextFormField(
      maxLines: 10, decoration: inputDecoration.copyWith(hintText: 'Me')),
  SizedBox(height: 10.0),
  FormButton(
    // TODO: POPULATE TEXT FIELDS THEN UPDATE/EDIT THE FIELDS IN THE DATABASE
    callback: () {},
  ),
];

//// Card Widget
class CardItem extends StatelessWidget {
  final CardEntity card;
  CardItem({@required this.card}) : assert(card != null);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToEditCardPage(card);
      },
      child: Container(
        decoration: decoration,
        padding: EdgeInsets.only(left: 10.0),
        child: Container(
          decoration: decoration.copyWith(color: AppTheme.cardSecColor),
          padding: EdgeInsets.all(10.0),
          child: ListTile(
            title: Text(
              "${card.front}",
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text(
              "21 June 2020",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////
// Deck Study Widgets

Widget checkSimilarityWidget({SimilarityBloc similarityBloc}) {
  return BlocBuilder<SimilarityBloc, SimilarityState>(
      bloc: similarityBloc,
      builder: (context, state) {
        if (state is SimilarityInitial) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.check_circle,
                    size: 40.0,
                  ),
                  onPressed: () {
                    similarityBloc.add(FetchSimilarityDataEvent(
                        myDefinition: "testing 12",
                        original: 'this is the original'));
                  }),
            ],
          );
        } else if (state is LoadedSimilarityState) {
          return Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.check_circle,
                    size: 40.0,
                  ),
                  onPressed: () {
                    similarityBloc.add(FetchSimilarityDataEvent(
                        myDefinition: "testing 12",
                        original: 'this is the original'));
                  }),
              SizedBox(width: 10.0),
              Text("${state.similarity.similar}"),
            ],
          ));
        } else if (state is ErrorSimilarityState) {
          return Center(child: Text("There was an error: ${state.message}"));
        }
        return loadingWidget();
      });
}

class DifficultyItem extends StatelessWidget {
  final String difficulty;
  final int cardsLeftCount;
  final Color color;
  final Function pressed;

  const DifficultyItem(
      {Key key, this.difficulty, this.cardsLeftCount, this.color, this.pressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: pressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration:
              decoration.copyWith(borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            children: <Widget>[
              Text(
                "$cardsLeftCount",
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
              Text(
                difficulty,
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TimeFrameItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function pressed;

  const TimeFrameItem({
    Key key,
    this.icon,
    this.label,
    this.pressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: pressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration:
              decoration.copyWith(borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            children: <Widget>[
              Text(
                "$label",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Icon(icon, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

Widget difficultyBar(context) {
  final notification = locator.get<LocalNotificationService>();
  return Container(
    height: 55.0,
    width: 375.0,
    decoration: decoration,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: DifficultyItem(
            difficulty: "Again",
            cardsLeftCount: 2,
            color: Colors.yellowAccent,
            pressed: () {
              notification.notification();
            },
          ),
        ),
        Expanded(
          child: DifficultyItem(
            difficulty: "Easy",
            cardsLeftCount: 3,
            color: Colors.lightGreenAccent,
            pressed: () {
              notification.notification();
            },
          ),
        ),
        Expanded(
          child: DifficultyItem(
            difficulty: "Hard",
            cardsLeftCount: 1,
            color: Colors.redAccent,
            pressed: () {
              notification.notification();
            },
          ),
        ),
      ],
    ),
  );
}
