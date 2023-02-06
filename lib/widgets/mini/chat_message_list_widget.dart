// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_chat_gpt/providers/messages_provider.dart';

import '../micro/chat_message_widget.dart';

class ChatMessageListViewWidget extends StatelessWidget {
  final ScrollController scrollController;

  const ChatMessageListViewWidget({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final msgProvider = context.watch<MessagesProvider>();
    final messages = msgProvider.messages;

    return GestureDetector(
      onTap: () => msgProvider.clearSelectedMessage(),
      child: ListView.builder(
        controller: scrollController,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          var message = messages[index];
          return GestureDetector(
            onLongPress: () {
              context.read<MessagesProvider>().setSelectedMessage(message);
            },
            child: ChatMessageWidget(
              chatMessage: message,
            ),
          );
        },
      ),
    );
  }
}
