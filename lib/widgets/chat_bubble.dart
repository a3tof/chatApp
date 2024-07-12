import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(
          left: 32,
          right: 32,
          top: 32,
          bottom: 32,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        decoration: const BoxDecoration(
          color: Color(0xff2b475e),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: const Text(
          'i\'am a new user',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
