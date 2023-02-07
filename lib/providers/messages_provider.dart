import 'package:flutter/foundation.dart';

import '../models/chat_message_model.dart';
import 'dmlist.dart';

class MessagesProvider extends ChangeNotifier {
  ChatMessage? _selectedMessage;
  ChatMessage? get selectedMessage => _selectedMessage;

  final List<ChatMessage> _messages = [...dummyMessages];

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
    _messages.add(chatMessage);
    notifyListeners();
  }

  void deleteMessage(ChatMessage chatMessage) {
    _messages.remove(chatMessage);

    clearSelectedMessage();
    notifyListeners();
  }
}
