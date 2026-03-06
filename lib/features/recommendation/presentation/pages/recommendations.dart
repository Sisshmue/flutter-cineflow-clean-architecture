import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cineflow/core/secrets/secrets_data.dart';
import 'package:cineflow/features/recommendation/presentation/widgets/genre_chip.dart';
import 'package:cineflow/features/recommendation/presentation/widgets/recommendations_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Recommendations extends StatefulWidget {
  const Recommendations({super.key});

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  final TextEditingController _controller = TextEditingController();
  static final String apiKey = SecretsData.gemnini_key;
  final model = GenerativeModel(
    model: 'gemini-2.5-flash',
    apiKey: apiKey,
    generationConfig: GenerationConfig(responseMimeType: 'application/json'),
  );
  List<dynamic> recommendations = [];
  bool isSearching = false;

  Future<void> getMovieList(String genre) async {
    try {
      final prompt =
          '''
      Generate a list of 5 movie recommendations for the genre: $genre.
      Return a JSON object with a key "movies" containing an array of objects.
      Each object must have:
      - "id": a unique string ID
      - "title": the movie name
      - "description": a short reason why it matches the genre
      - "image": the network image link of the movie
    ''';

      final response = await model.generateContent([Content.text(prompt)]);

      // Clean potential markdown formatting from the response
      String rawJson = response.text!
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();

      final Map<String, dynamic> data = jsonDecode(rawJson);

      setState(() {
        recommendations = data['movies'];
        isSearching = false; // Turn off the spinner
      });
    } catch (e) {
      debugPrint("Error: $e");
      setState(() {
        isSearching = false;
      });
      // Optional: Show a SnackBar error here
    }
  }

  bool showChips = false;

  void _sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    setState(() {
      isSearching = true;
    });
    await getMovieList(text);
    _controller.clear();
    setState(() {
      isSearching = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showChips = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: isSearching
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.redAccent),
                    )
                  : recommendations.isEmpty
                  ? const Center(child: Text('Type a genre to get started!'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: recommendations.length,
                      itemBuilder: (context, index) {
                        final movie = recommendations[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    12,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: movie['image'],
                                    progressIndicatorBuilder:
                                        (context, url, progress) =>
                                            CupertinoActivityIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.movie),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    movie['title'] ?? 'Unknown Title',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(movie['description'] ?? ''),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            if (showChips) GenreChip(sendMessage: _sendMessage),
            RecommendationsInput(
              controller: _controller,
              sendMessage: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
