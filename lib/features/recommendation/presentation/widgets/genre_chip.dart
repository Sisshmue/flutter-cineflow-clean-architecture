import 'package:flutter/material.dart';

class GenreChip extends StatelessWidget {
  final void Function(String text) sendMessage;
  const GenreChip({super.key, required this.sendMessage});

  @override
  Widget build(BuildContext context) {
    final List<String> _genres = [
      'Action',
      'Sci-Fi',
      'Comedy',
      'Horror',
      'Drama',
    ];
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _genres.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ActionChip(
              label: Text(_genres[index]),
              backgroundColor: Colors.blueAccent.withOpacity(0.1),
              labelStyle: const TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
              shape: StadiumBorder(
                side: BorderSide(color: Colors.blueAccent.withOpacity(0.2)),
              ),
              onPressed: () => sendMessage(_genres[index]),
            ),
          );
        },
      ),
    );
  }
}
