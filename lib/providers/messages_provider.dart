import 'package:flutter/foundation.dart';

import '../constants/constants.dart';
import '../models/chat_message_model.dart';

class MessagesProvider extends ChangeNotifier {
  ChatMessage? _selectedMessage;
  ChatMessage? get selectedMessage => _selectedMessage;

  List<ChatMessage> get messages => messagesBox.values.toList()
    ..sort(
      (a, b) => a.createdOn.compareTo(b.createdOn),
    );

  void setSelectedMessage(ChatMessage chatMessage) {
    _selectedMessage = chatMessage;

    notifyListeners();
  }

  void clearSelectedMessage() {
    _selectedMessage = null;
    notifyListeners();
  }

  void addMessage(ChatMessage chatMessage) async {
    await messagesBox.put(chatMessage.id, chatMessage);
    notifyListeners();
  }

  void deleteMessage(ChatMessage chatMessage) {
    messagesBox.delete(chatMessage.id);

    clearSelectedMessage();
    notifyListeners();
  }
}
