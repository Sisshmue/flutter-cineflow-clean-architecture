import 'package:flutter/material.dart';

class GenreChip extends StatelessWidget {
  final void Function(String text) sendMessage;

  const GenreChip({super.key, required this.sendMessage});

  @override
  Widget build(BuildContext context) {
    final genres = [
      'Action',
      'Sci-Fi',
      'Comedy',
      'Horror',
      'Drama',
      'Thriller',
      'Adventure',
    ];

    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => sendMessage(genres[index]),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color(0xff1f1f1f),
                border: Border.all(color: Colors.white10),
              ),
              child: Center(
                child: Text(
                  genres[index],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
