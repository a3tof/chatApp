part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

// ignore: must_be_immutable
final class ChatSuccess extends ChatState {
  List<Message> messages;
  ChatSuccess({required this.messages});
}
