import 'package:flutter/cupertino.dart';

import '../models/chat_message_model.dart';

class MessagesListProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages;

  void addMessage(ChatMessage chatMessage) {
    _messages.add(chatMessage);
    notifyListeners();
  }
}
