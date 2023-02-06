import 'package:flutter/foundation.dart';

import '../models/chat_message_model.dart';

class MessagesProvider extends ChangeNotifier {
  ChatMessage? _selectedMessage;
  ChatMessage? get selectedMessage => _selectedMessage;
  int _previousMessagesLength = 0;
  int _messagesLength = 0;
  int get previousMessageLength => _previousMessagesLength;
  int get messagesLength => _messagesLength;

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

  void setSelectedMessage(ChatMessage chatMessage) {
    _selectedMessage = chatMessage;

    notifyListeners();
  }

  void clearSelectedMessage() {
    _selectedMessage = null;
    notifyListeners();
  }

  void addMessage(ChatMessage chatMessage) {
    _previousMessagesLength = _messages.length;
    _messages.add(chatMessage);
    _messagesLength = messages.length;
    notifyListeners();
  }

  void deleteMessage(ChatMessage chatMessage) {
    _previousMessagesLength = messages.length;
    _messages.remove(chatMessage);
    _messagesLength = messages.length;

    clearSelectedMessage();
    notifyListeners();
  }
}
