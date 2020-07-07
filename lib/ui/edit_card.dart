import 'package:flutter/material.dart';
import 'package:study_buddy/models/card.dart';

import 'package:study_buddy/ui/shared/theme.dart';
import 'package:study_buddy/ui/shared_widgets/shared_widgets.dart';

class EditCardPage extends StatelessWidget {
  final CardEntity cardEntity;
  EditCardPage({@required this.cardEntity});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.themeColor,
      appBar: appBar(context, title: "Edit Card"),
      body: formWidgetBuilder(formItems: cardFormItems),
    );
  }
}
