import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, Color backGroundColor) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: backGroundColor,
  ));
}
