import 'package:flutter/material.dart';

class Widgets {
  static void showSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(content)));
  }
}
