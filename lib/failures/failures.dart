import 'package:flutter/foundation.dart';

class Failure {
  final String message;
  Failure(this.message);

  @override
  String toString() => message;
}
