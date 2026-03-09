import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MovieGridSkeleton extends StatelessWidget {
  const MovieGridSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade900,
      highlightColor: Colors.grey.shade800,
      child: CustomScrollView(
        slivers: [
          // Match your Search Bar vertical padding
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: SizedBox(height: 50), // Matches search bar height
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.7, // Matches your MovieCard ratio
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Poster Skeleton
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Title Line 1
                  Container(
                    height: 14,
                    width: double.infinity,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 4),
                  // Title Line 2/Subtitle
                  Container(height: 12, width: 100, color: Colors.black),
                ],
              ),
              childCount: 6, // Show enough items to fill the screen
            ),
          ),
        ],
      ),
    );
  }
}
