import 'package:cached_network_image/cached_network_image.dart';
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
              child: CachedNetworkImage(
                imageUrl: movie.posterUrl,
                fit: BoxFit.cover,
                placeholder: (context, error) {
                  return Center(child: CircularProgressIndicator());
                },
                errorWidget: (context, url, error) {
                  return Center(
                    child: Icon(
                      Icons.movie,
                      size: 50,
                      color: Pallete.textDisabled,
                    ),
                  );
                },
              ),
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
          "${movie.releaseDate} :  ${movie.type}",
          style: const TextStyle(color: Pallete.textSecondary, fontSize: 12),
        ),
      ],
    );
  }
}
