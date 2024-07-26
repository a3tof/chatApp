import 'package:chatapp/constants.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/views/cubits/chat_cubit/cubit/chat_cubit.dart';
import 'package:chatapp/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable, camel_case_types
class chatPage extends StatelessWidget {
  static String id = 'ChatPage';

  final _controller = ScrollController();
  List<Message> messagesList = [];

  TextEditingController controller = TextEditingController();

  chatPage({super.key});

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String? ?? '';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 50,
            ),
            const Text(
              'Chat',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messagesList =
                    BlocProvider.of<ChatCubit>(context).messagesList;
                return ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBubble(
                              message: messagesList[index],
                            )
                          : ChatBubbleForFriend(message: messagesList[index]);
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context).sendMessage(
                  email: email,
                  message: data,
                );
                controller.clear();
                _controller.animateTo(
                  _controller.position.minScrollExtent,
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                );
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: kPrimaryColor,
                  ),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      BlocProvider.of<ChatCubit>(context).sendMessage(
                        email: email,
                        message: controller.text,
                      );
                      controller.clear();
                      _controller.animateTo(
                        _controller.position.minScrollExtent,
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                      );
                    }
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: kPrimaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
