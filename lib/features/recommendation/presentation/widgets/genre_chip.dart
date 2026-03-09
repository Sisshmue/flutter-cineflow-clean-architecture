import 'package:cineflow/core/theme/pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class GenreChip extends StatelessWidget {
  final void Function(String text) sendMessage;

  const GenreChip({super.key, required this.sendMessage});

  // Inside GenreChip class
  @override
  Widget build(BuildContext context) {
    final genres = [
      'Action',
      'Sci-Fi',
      'Comedy',
      'Horror',
      'Drama',
      'Thriller',
    ];

    return SizedBox(
      height: 40,
      child: AnimationLimiter(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          itemCount: genres.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 600),
              child: SlideAnimation(
                horizontalOffset: 100.0, // Slides in from the right
                child: FadeInAnimation(
                  child: AnimatedGenreChip(
                    label: genres[index],
                    onTap: () => sendMessage(genres[index]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AnimatedGenreChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const AnimatedGenreChip({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          // Gradient background for depth
          gradient: LinearGradient(
            colors: [
              CupertinoColors.destructiveRed.withOpacity(0.1),
              Colors.redAccent.withOpacity(0.05),
            ],
          ),
          // Glowing border
          border: Border.all(
            color: Pallete.primaryRed.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.auto_awesome, size: 14, color: Colors.red),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
