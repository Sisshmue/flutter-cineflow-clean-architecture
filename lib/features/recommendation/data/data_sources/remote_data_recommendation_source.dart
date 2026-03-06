import 'dart:convert';

import 'package:cineflow/features/recommendation/data/model/recommendation_mode.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../../../core/secrets/secrets_data.dart';

abstract interface class RemoteDataRecommendationSource {
  Future<List<RecommendationModel>> getRecommendations({
    required String parameter,
  });
}

class RemoteDataRecommendationSourceImpl
    implements RemoteDataRecommendationSource {
  static final String apiKey = SecretsData.gemnini_key;
  final model = GenerativeModel(
    model: 'gemini-2.5-flash',
    apiKey: apiKey,
    generationConfig: GenerationConfig(responseMimeType: 'application/json'),
  );
  @override
  Future<List<RecommendationModel>> getRecommendations({
    required String parameter,
  }) async {
    try {
      final prompt =
          '''
      Generate a list of 5 movie recommendations for the genre: $parameter.
      Return a JSON object with a key "movies" containing an array of objects.
      Each object must have:
      - "id": a unique string ID
      - "title": the movie name
      - "description": a short reason why it matches the genre
      - "image": the actual working network image link for the movie poster
      - "year": released date of the movie
    ''';

      print(prompt);

      final response = await model.generateContent([Content.text(prompt)]);

      // Clean potential markdown formatting from the response
      String rawJson = response.text!
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();
      print(rawJson);

      final Map<String, dynamic> data = jsonDecode(rawJson);
      if (data['movies'] is List) {
        return data['movies']
            .map<RecommendationModel>(
              (json) => RecommendationModel.fromJson(json),
            )
            .toList();
      } else {
        throw 'data["movie"] is not a list';
      }
    } catch (e) {
      throw 'Fail to get the recommendations!';
    }
  }
}
