import 'package:flutter/foundation.dart';
import 'package:study_buddy/models/similarity.dart';

abstract class SimilarityRepository {
  Future<Similarity> fetchSimilarityData(
      {@required String original, myDefenition});
}
