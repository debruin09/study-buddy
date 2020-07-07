import 'package:flutter/material.dart';
import 'package:study_buddy/ui/shared/theme.dart';

const SCREEN_WIDTH = 420;

class ScreenSize {
  static double screenHeight(context) => MediaQuery.of(context).size.height;
  static double screenWidth(context) => MediaQuery.of(context).size.width;
  ScreenSize() {
    print("This is the data: $screenHeight and $screenWidth");
  }
}

final BoxDecoration decoration = BoxDecoration(
  border: Border(),
  color: AppTheme.cardColor,
  borderRadius: BorderRadius.all(
    Radius.circular(20.0),
  ),
  // boxShadow: [
  //   BoxShadow(
  //       color: Colors.black.withOpacity(0.7),
  //       offset: Offset(4, 4),
  //       blurRadius: 8.0),
  //   BoxShadow(
  //       color: Colors.white.withOpacity(0.7),
  //       offset: Offset(-4, -4),
  //       blurRadius: 8.0)
  // ]
);

const InputDecoration inputDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
  ),
  fillColor: Colors.white,
  filled: true,
);
