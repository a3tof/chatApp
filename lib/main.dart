import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/views/chat_view.dart';
import 'package:chatapp/views/cubits/login_cubit/login_cubit.dart';
import 'package:chatapp/views/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: MaterialApp(
        routes: {chatPage.id: (context) => chatPage()},
        home: LoginPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
