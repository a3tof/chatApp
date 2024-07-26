import 'package:chatapp/helper/show_snack_bar.dart';
import 'package:chatapp/views/chat_view.dart';
import 'package:chatapp/views/cubits/chat_cubit/cubit/chat_cubit.dart';
import 'package:chatapp/views/cubits/login_cubit/login_cubit.dart';
import 'package:chatapp/views/register_view.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_text_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  String? email;

  String? password;
  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSucces) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, chatPage.id);
          isLoading = false;
        } else if (state is LoginFailure) {
          showSnackBar(
            context,
            state.errMessage,
            Colors.red,
          );
          isLoading = false;
        }
      },
      child: ModalProgressHUD(
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
                    obscureText: true,
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
                        BlocProvider.of<LoginCubit>(context)
                            .loginUser(email: email!, password: password!);
                      } else {}
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
                              return RegisterView();
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
      ),
    );
  }
}
