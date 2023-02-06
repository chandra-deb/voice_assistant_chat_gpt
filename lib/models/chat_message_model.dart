import 'package:uuid/uuid.dart';

enum ChatMessageType { user, bot }

class ChatMessage {
  final String id;
  final String text;
  final ChatMessageType chatMessageType;
  ChatMessage({
    required this.text,
    required this.chatMessageType,
  }) : id = const Uuid().v4();
}
