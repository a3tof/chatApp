import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is LoginEvent) {
          emit(LoginLoading());

          try {
            UserCredential user = await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: event.email, password: event.password);
            emit(LoginSucces());
          } on FirebaseAuthException catch (ex) {
            if (ex.code == 'user-not-found') {
              emit(LoginFailure(errMessage: 'User not found'));
            } else if (ex.code == 'wrong-password') {
              emit(LoginFailure(errMessage: 'Wrong password'));
            } else if (ex.code == 'invalid-email') {
              emit(LoginFailure(errMessage: 'Invalid email'));
            } else {
              emit(LoginFailure(errMessage: 'There was an error'));
            }
          } catch (e) {
            emit(LoginFailure(errMessage: 'There was an error'));
          }
        }
        if (event is RegisterEvent) {
          emit(RegisterLoading());
          try {
            UserCredential user = await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: event.email, password: event.password);
            emit(RegisterSuccess());
          } on FirebaseAuthException catch (ex) {
            if (ex.code == 'weak-password') {
              emit(RegisterFailure(
                  errMessage: 'The password provided is too weak.'));
            } else if (ex.code == 'email-already-in-use') {
              emit(RegisterFailure(
                  errMessage: 'The account already exists for that email.'));
            }
          } catch (e) {
            emit(RegisterFailure(
                errMessage: 'There was an error please try again'));
          }
        }
      },
    );
  }
}
