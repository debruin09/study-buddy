import 'package:study_buddy/models/tag_entity.dart';

abstract class TagRepository {
  Future<List<TagEntity>> getTags(String query);
}
