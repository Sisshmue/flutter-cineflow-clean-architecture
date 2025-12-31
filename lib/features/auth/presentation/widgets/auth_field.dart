import 'package:cineflow/core/theme/pallete.dart';
import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;

  const AuthField({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Pallete.surface,
        hintText: hintText,
        hintStyle: TextStyle(color: Pallete.textDisabled),
        prefixIcon: Icon(icon, color: Pallete.primaryRed),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
