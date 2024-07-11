import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.title});
  String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.infinity,
      height: 50,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xff2b475e),
          ),
        ),
      ),
    );
  }
}
