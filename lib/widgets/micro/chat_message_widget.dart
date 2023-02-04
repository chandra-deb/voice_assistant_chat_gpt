import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../models/chat_message_model.dart';
import 'individual_message_widget.dart';

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({
    super.key,
    required this.text,
    required this.chatMessageType,
  });

  final String text;
  final ChatMessageType chatMessageType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: chatMessageType == ChatMessageType.bot
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: <Widget>[
                IndividualMessage(
                  text: text,
                  type: chatMessageType,
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fade().slide(
          duration: const Duration(milliseconds: 100),
        );
  }
}
