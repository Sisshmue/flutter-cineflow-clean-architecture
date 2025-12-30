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
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(movie.posterUrl, fit: BoxFit.cover),
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
