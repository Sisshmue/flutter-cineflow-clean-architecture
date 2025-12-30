import 'package:cineflow/core/theme/pallete.dart';
import 'package:flutter/material.dart';

class MovieSearchBar extends StatelessWidget {
  const MovieSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Pallete.surface,
        hintText: 'Search movies...',
        hintStyle: const TextStyle(color: Pallete.textDisabled),
        prefixIcon: const Icon(Icons.search, color: Pallete.primaryRed),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
