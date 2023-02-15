import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../constants/constants.dart';
import '../models/chat_message_model.dart';

class MessagesProvider extends ChangeNotifier {
  ChatMessage? _selectedMessage;
  ChatMessage? get selectedMessage => _selectedMessage;

  List<ChatMessage> get messages {
    return messagesBox.values.toList()
      ..sort(
        (a, b) => a.createdOn.compareTo(b.createdOn),
      );
  }

  void setSelectedMessage(ChatMessage chatMessage) {
    HapticFeedback.lightImpact();
    _selectedMessage = chatMessage;

    notifyListeners();
  }

  void clearSelectedMessage() {
    _selectedMessage = null;
    notifyListeners();
  }

  void addMessage(ChatMessage chatMessage) async {
    await messagesBox.add(chatMessage);
    notifyListeners();
  }

  void deleteMessage(ChatMessage chatMessage) async {
    await chatMessage.delete();

    clearSelectedMessage();
    notifyListeners();
  }
}
