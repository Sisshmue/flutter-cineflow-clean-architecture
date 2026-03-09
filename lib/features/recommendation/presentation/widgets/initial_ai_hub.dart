import 'package:cineflow/core/theme/pallete.dart';
import 'package:cineflow/features/recommendation/presentation/bloc/recommendation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialAIHub extends StatefulWidget {
  final void Function(String text) sendMessage;
  const InitialAIHub({super.key, required this.sendMessage});

  @override
  State<InitialAIHub> createState() => _InitialAIHubState();
}

class _InitialAIHubState extends State<InitialAIHub>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // The Glowing Neural Icon
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Pallete.primaryRed.withOpacity(
                        0.2 * _controller.value,
                      ),
                      blurRadius: 40,
                      spreadRadius: 10 * _controller.value,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.auto_awesome,
                  size: 80,
                  color: Colors.redAccent.withOpacity(
                    0.5 + (0.5 * _controller.value),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 30),
          const Text(
            "CineFlow AI",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "What are we in the mood for?",
            style: TextStyle(color: Colors.white54, fontSize: 16),
          ),
          const SizedBox(height: 40),

          // Floating Prompt Suggestions
          _buildPrompt(
            "Suggest a mind-bending thriller...",
            widget.sendMessage,
          ),
          _buildPrompt(
            "Something like 'Inception' but shorter",
            widget.sendMessage,
          ),
        ],
      ),
    );
  }

  Widget _buildPrompt(String text, void Function(String) callback) {
    return GestureDetector(
      onTap: () {
        callback(text);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white10),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white38, fontSize: 13),
        ),
      ),
    );
  }
}
