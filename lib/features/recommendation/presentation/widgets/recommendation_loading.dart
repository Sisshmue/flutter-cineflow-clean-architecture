import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecommendationLoadingWidget extends StatelessWidget {
  const RecommendationLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 6,
      itemBuilder: (_, _) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade800,
          highlightColor: Colors.grey.shade600,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 18, width: 200, color: Colors.white),
                const SizedBox(height: 10),
                Container(
                  height: 12,
                  width: double.infinity,
                  color: Colors.white,
                ),
                const SizedBox(height: 6),
                Container(
                  height: 12,
                  width: double.infinity,
                  color: Colors.white,
                ),
                const SizedBox(height: 6),
                Container(height: 12, width: 150, color: Colors.white),
              ],
            ),
          ),
        );
      },
    );
  }
}
