import 'package:cineflow/core/theme/pallete.dart';
import 'package:flutter/material.dart';
import '../../domain/entity/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Pallete.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(Icons.movie, size: 50, color: Pallete.textDisabled),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          movie.title,
          maxLines: 1,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          "${movie.releaseDate} • ★ ${movie.rating}",
          style: const TextStyle(color: Pallete.textSecondary, fontSize: 12),
        ),
      ],
    );
  }
}
