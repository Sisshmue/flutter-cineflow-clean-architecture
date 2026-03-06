import 'package:flutter/material.dart';
import '../../../../core/theme/pallete.dart';

class RecommendationsInput extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String text) sendMessage;
  const RecommendationsInput({
    super.key,
    required this.controller,
    required this.sendMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Ask for a recommendation...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Colors.grey,
              child: IconButton(
                icon: const Icon(
                  Icons.send,
                  color: Pallete.accentGold,
                  size: 20,
                ),
                onPressed: () => sendMessage(controller.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
