// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_chat_gpt/providers/messages_provider.dart';

import '../micro/chat_message_widget.dart';

class ChatMessageListViewWidget extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  ChatMessageListViewWidget({
    Key? key,
  }) : super(key: key);

  void showListViewBottom(BuildContext context) {
    final msgProvider = context.read<MessagesProvider>();
    final prevMsgsLength = msgProvider.previousMessageLength;
    final msgsLength = msgProvider.messagesLength;
    if (msgsLength > prevMsgsLength) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn);
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    showListViewBottom(context);
    final msgProvider = context.watch<MessagesProvider>();
    final messages = msgProvider.messages;

    return GestureDetector(
      onTap: () => msgProvider.clearSelectedMessage(),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          var message = messages[index];
          return GestureDetector(
            onLongPress: () {
              context.read<MessagesProvider>().setSelectedMessage(message);
            },
            child: ChatMessageWidget(
              text: message.text,
              chatMessageType: message.chatMessageType,
            ),
          );
        },
      ),
    );
  }
}
