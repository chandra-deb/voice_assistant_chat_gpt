import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../constants/constants.dart';
import '../../models/chat_message_model.dart';
import 'individual_message_widget.dart';

class ChatMessageWidget extends StatelessWidget {
  final void Function() showOverlay;
  final void Function() closeOverLay;
  const ChatMessageWidget(
      {super.key,
      required this.text,
      required this.chatMessageType,
      required this.showOverlay,
      required this.closeOverLay});

  final String text;
  final ChatMessageType chatMessageType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(16),
      color: chatMessageType == ChatMessageType.bot
          ? botBackgroundColor
          : backgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          chatMessageType == ChatMessageType.bot
              ? Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    backgroundColor: const Color.fromRGBO(16, 163, 127, 1),
                    child: Image.asset(
                      'assets/bot.jpg',
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: const CircleAvatar(
                    child: Icon(
                      Icons.person,
                    ),
                  ),
                ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IndividualMessage(
                  text: text,
                  type: chatMessageType,
                  showOverlay: showOverlay,
                  closeOverLay: closeOverLay,
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fade().slide(duration: const Duration(milliseconds: 100));
  }
}
