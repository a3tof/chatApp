import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/simple_bloc_observer.dart';
import 'package:chatapp/views/blocs/auth_bloc/auth_bloc.dart';
import 'package:chatapp/views/chat_view.dart';

import 'package:chatapp/views/cubits/chat_cubit/cubit/chat_cubit.dart';
import 'package:chatapp/views/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ignore: deprecated_member_use
  BlocOverrides.runZoned(
    () {
      runApp(const ChatApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatCubit>(
          create: (context) => ChatCubit(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
        routes: {chatPage.id: (context) => chatPage()},
        home: LoginPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
