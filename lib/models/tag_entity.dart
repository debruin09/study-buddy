import 'package:flutter_tagging/flutter_tagging.dart';

class TagEntity extends Taggable {
  final String tag;

// Creates tags
  TagEntity({
    this.tag,
  });

  @override
  List<Object> get props => [tag];
}
