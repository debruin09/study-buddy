import 'package:flutter/material.dart';
import 'package:study_buddy/ui/shared/theme.dart';
import 'package:study_buddy/ui/shared_widgets/shared_widgets.dart';

class CreateNewCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.themeColor,
      appBar: appBar(context, title: "Create New Card"),
      body: formWidgetBuilder(formItems: cardFormItems),
    );
  }
}
