// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../models/chat_message_model.dart';
import 'individual_message_widget.dart';

class ChatMessageWidget extends StatelessWidget {
  final void Function() showOverlay;
  final void Function() closeOverLay;
  const ChatMessageWidget({
    Key? key,
    required this.showOverlay,
    required this.closeOverLay,
    required this.text,
    required this.chatMessageType,
  }) : super(key: key);

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
                  showOverlay: showOverlay,
                  closeOverLay: closeOverLay,
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
