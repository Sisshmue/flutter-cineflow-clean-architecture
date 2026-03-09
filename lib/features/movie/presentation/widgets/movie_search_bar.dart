import 'package:cineflow/core/theme/pallete.dart';
import 'package:cineflow/features/movie/presentation/bloc/movie/movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchSubmitted; // ← Add this

  const MovieSearchBar({
    super.key,
    required this.searchController,
    required this.onSearchSubmitted, // ← Add this
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      style: const TextStyle(color: Colors.white),
      onSubmitted: onSearchSubmitted, // ← Use callback instead of dispatching directly
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
