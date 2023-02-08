import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'chat_message_model.g.dart';

@HiveType(typeId: 0)
enum ChatMessageType {
  @HiveField(0)
  user,
  @HiveField(1)
  bot,
}

@HiveType(typeId: 1)
class ChatMessage {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String text;
  @HiveField(2)
  final ChatMessageType chatMessageType;

  ChatMessage({
    required this.text,
    required this.chatMessageType,
  }) : id = const Uuid().v4();
}
