// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_chat_gpt/providers/messages_list_provider.dart';

import '../micro/chat_message_widget.dart';

class ChatMessageListViewWidget extends StatelessWidget {
  final ScrollController scrollController;
  final void Function() showOverlay;
  final void Function() closeOverLay;

  const ChatMessageListViewWidget({
    Key? key,
    required this.scrollController,
    required this.showOverlay,
    required this.closeOverLay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messages = context.watch<MessagesListProvider>().messages;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              var message = messages[index];
              return ChatMessageWidget(
                text: message.text,
                chatMessageType: message.chatMessageType,
                showOverlay: showOverlay,
                closeOverLay: closeOverLay,
              );
            },
          ),
        ),
      ],
    );
  }
}
