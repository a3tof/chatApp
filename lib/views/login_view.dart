import 'package:chatapp/helper/show_snack_bar.dart';
import 'package:chatapp/views/chat_view.dart';
import 'package:chatapp/views/register_view.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_text_filed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? password;
  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.white,
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: const Color(0xff2b475e),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 100,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'FriendHub Chat',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'pacifico',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 75,
                ),
                const Row(
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomFormTextFiled(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomFormTextFiled(
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomButton(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await LoginUser();
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(context, ChatPage.id);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'user-not-found') {
                          // ignore: use_build_context_synchronously
                          showSnackBar(context, 'No user found for that email.',
                              Colors.red);
                        } else if (ex.code == 'wrong-password') {
                          showSnackBar(
                              // ignore: use_build_context_synchronously
                              context,
                              'Wrong password provided for that user.',
                              Colors.red);
                        } else if (ex.code == 'invalid-email') {
                          showSnackBar(
                              // ignore: use_build_context_synchronously
                              context,
                              'Invalid email provided.',
                              Colors.red);
                        } else {
                          showSnackBar(
                              // ignore: use_build_context_synchronously
                              context,
                              'Authentication error: ${ex.message}',
                              Colors.red);
                        }
                      } catch (ex) {
                        print(ex);
                        // ignore: use_build_context_synchronously
                        showSnackBar(context, 'There was an error', Colors.red);
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                  title: 'SIGN IN',
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const RegisterView();
                          }),
                        );
                      },
                      child: const Text(
                        ' Register Now',
                        style: TextStyle(
                          color: Color(0xffc7ede6),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> LoginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
