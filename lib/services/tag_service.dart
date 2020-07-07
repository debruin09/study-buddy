import 'package:study_buddy/models/tag_entity.dart';
import 'package:study_buddy/repositories/tag_repository.dart';

class TagService implements TagRepository {
  @override
  Future<List<TagEntity>> getTags(String query) async {
    await Future.delayed(Duration(milliseconds: 500), null);
    return <TagEntity>[
      TagEntity(
        tag: 'JavaScript',
      ),
      TagEntity(
        tag: 'Python',
      ),
      TagEntity(
        tag: 'Java',
      ),
    ].where((t) => t.tag.toLowerCase().contains(query.toLowerCase())).toList();
  }
}
