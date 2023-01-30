// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';

import '../models/chat_message_model.dart';
import 'chat_message_widget.dart';

class ChatMessageListViewWidget extends StatelessWidget {
  final List<ChatMessage> messages;
  final ScrollController scrollController;
  const ChatMessageListViewWidget({
    Key? key,
    required this.messages,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        var message = messages[index];
        return ChatMessageWidget(
          text: message.text,
          chatMessageType: message.chatMessageType,
        );
      },
    );
  }
}
