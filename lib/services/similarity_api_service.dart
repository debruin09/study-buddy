import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:study_buddy/models/similarity.dart';
import 'package:study_buddy/repositories/similarity_repository.dart';

class SimilarityApiService implements SimilarityRepository {
  final Client client = Client();
  final String _apiToken = "8fcd8721c99c42baa1b5d9f0c974770e";

  @override
  Future<Similarity> fetchSimilarityData(
      {String original, myDefenition}) async {
    final String endPoint = "https://api.dandelion.eu/datatxt/sim/v1";
    final response = await client.post(
        "$endPoint?text1=$original&lang=en&text2=$myDefenition&token=$_apiToken");

    if (response.statusCode == 200) {
      final jsonDecoded = json.decode(response.body);
      return Similarity.fromMap(jsonDecoded);
    } else {
      throw Exception('Failed to load response');
    }
  }
}
