import 'package:study_buddy/models/similarity.dart';
import 'package:study_buddy/repositories/similarity_repository.dart';

class MockApiService implements SimilarityRepository {
  final bool error = false;
  @override
  Future<Similarity> fetchSimilarityData(
      {String original, myDefenition}) async {
    await Future.delayed(Duration(milliseconds: 300));
    return Similarity(similar: 0.9);
    //: Exception(["Error fetching data"]);
  }
}
