import 'package:flutter/foundation.dart';

import '../models/chat_message_model.dart';

class MessagesListProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [
    ChatMessage(text: 'Hi', chatMessageType: ChatMessageType.user),
    ChatMessage(
        text: 'Hey! How are you?', chatMessageType: ChatMessageType.bot),
    ChatMessage(
        text: 'I am fine. What about you?',
        chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'I am fine, too.', chatMessageType: ChatMessageType.bot),
    ChatMessage(text: 'Last Message', chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'Hi', chatMessageType: ChatMessageType.user),
    ChatMessage(
        text: 'Hey! How are you?', chatMessageType: ChatMessageType.bot),
    ChatMessage(
        text: 'I am fine. What about you?',
        chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'I am fine, too.', chatMessageType: ChatMessageType.bot),
    ChatMessage(text: 'Last Message', chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'Hi', chatMessageType: ChatMessageType.user),
    ChatMessage(
        text: 'Hey! How are you?', chatMessageType: ChatMessageType.bot),
    ChatMessage(
        text: 'I am fine. What about you?',
        chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'I am fine, too.', chatMessageType: ChatMessageType.bot),
    ChatMessage(text: 'Last Message', chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'Hi', chatMessageType: ChatMessageType.user),
    ChatMessage(
        text: 'Hey! How are you?', chatMessageType: ChatMessageType.bot),
    ChatMessage(
        text: 'I am fine. What about you?',
        chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'I am fine, too.', chatMessageType: ChatMessageType.bot),
    ChatMessage(text: 'Last Message', chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'Hi', chatMessageType: ChatMessageType.user),
    ChatMessage(
        text: 'Hey! How are you?', chatMessageType: ChatMessageType.bot),
    ChatMessage(
        text: 'I am fine. What about you?',
        chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'I am fine, too.', chatMessageType: ChatMessageType.bot),
    ChatMessage(text: 'Last Message', chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'Hi', chatMessageType: ChatMessageType.user),
    ChatMessage(
        text: 'Hey! How are you?', chatMessageType: ChatMessageType.bot),
    ChatMessage(
        text: 'I am fine. What about you?',
        chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'I am fine, too.', chatMessageType: ChatMessageType.bot),
    ChatMessage(text: 'Last Message', chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'Hi', chatMessageType: ChatMessageType.user),
    ChatMessage(
        text: 'Hey! How are you?', chatMessageType: ChatMessageType.bot),
    ChatMessage(
        text: 'I am fine. What about you?',
        chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'I am fine, too.', chatMessageType: ChatMessageType.bot),
    ChatMessage(text: 'Last Message', chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'Hi', chatMessageType: ChatMessageType.user),
    ChatMessage(
        text: 'Hey! How are you?', chatMessageType: ChatMessageType.bot),
    ChatMessage(
        text: 'I am fine. What about you?',
        chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'I am fine, too.', chatMessageType: ChatMessageType.bot),
    ChatMessage(text: 'Last Message', chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'Hi', chatMessageType: ChatMessageType.user),
    ChatMessage(
        text: 'Hey! How are you?', chatMessageType: ChatMessageType.bot),
    ChatMessage(
        text: 'I am fine. What about you?',
        chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'I am fine, too.', chatMessageType: ChatMessageType.bot),
    ChatMessage(text: 'Last Message', chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'Hi', chatMessageType: ChatMessageType.user),
    ChatMessage(
        text: 'Hey! How are you?', chatMessageType: ChatMessageType.bot),
    ChatMessage(
        text: 'I am fine. What about you?',
        chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'I am fine, too.', chatMessageType: ChatMessageType.bot),
    ChatMessage(text: 'Last Message', chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'Hi', chatMessageType: ChatMessageType.user),
    ChatMessage(
        text: 'Hey! How are you?', chatMessageType: ChatMessageType.bot),
    ChatMessage(
        text: 'I am fine. What about you?',
        chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'I am fine, too.', chatMessageType: ChatMessageType.bot),
    ChatMessage(text: 'Last Message', chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'Hi', chatMessageType: ChatMessageType.user),
    ChatMessage(
        text: 'Hey! How are you?', chatMessageType: ChatMessageType.bot),
    ChatMessage(
        text: 'I am fine. What about you?',
        chatMessageType: ChatMessageType.user),
    ChatMessage(text: 'I am fine, too.', chatMessageType: ChatMessageType.bot),
    ChatMessage(text: 'Last Message', chatMessageType: ChatMessageType.user),
  ];

  List<ChatMessage> get messages => _messages;

  void addMessage(ChatMessage chatMessage) {
    _messages.add(chatMessage);
    notifyListeners();
  }
}
