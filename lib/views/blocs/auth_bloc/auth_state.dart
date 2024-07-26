part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {}

final class RegisterFailure extends AuthState {
  final String errMessage;

  RegisterFailure({required this.errMessage});
}

final class LoginSucces extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginFailure extends AuthState {
  final String errMessage;

  LoginFailure({required this.errMessage});
}
