import 'package:chatapp/models/message.dart';
import 'package:chatapp/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'ChatPage';
  final ScrollController controllerr = ScrollController();
  final CollectionReference messageCollection =
      FirebaseFirestore.instance.collection('message');
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String?;

    if (email == null) {
      // Handle the case where email is null
      return Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
        ),
        body: const Center(
          child: Text('No email provided.'),
        ),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream:
          messageCollection.orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (var doc in snapshot.data!.docs) {
            messagesList.add(Message.fromJson(doc));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xff2b475e),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/scholar.png',
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
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: controllerr,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBubble(message: messagesList[index])
                          : ChatBubbleForFriend(message: messagesList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) async {
                      if (data.isNotEmpty) {
                        try {
                          await messageCollection.add({
                            'messagee': data,
                            'createdAt': DateTime.now(),
                            'id': email,
                          });
                          controller.clear();
                          controllerr.animateTo(
                            controllerr.position.maxScrollExtent,
                            curve: Curves.easeIn,
                            duration: const Duration(milliseconds: 500),
                          );
                        } catch (e) {
                          print('Error adding message to Firestore: $e');
                        }
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: const Icon(
                        Icons.send,
                        color: Color(0xff2b475e),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xff2b475e),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xff2b475e),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text(
              'Loading...',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
      },
    );
  }
}
