import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../models/chat_message_model.dart';
import '../providers/text_to_speech_provider.dart';

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget(
      {super.key, required this.text, required this.chatMessageType});

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
                IndividualMessage(text: text, type: chatMessageType),
              ],
            ),
          ),
        ],
      ),
    ).animate().fade().slide(duration: const Duration(milliseconds: 100));
  }
}

class IndividualMessage extends StatelessWidget {
  const IndividualMessage({
    Key? key,
    required this.text,
    required this.type,
  }) : super(key: key);

  final String text;
  final ChatMessageType type;

  @override
  Widget build(BuildContext context) {
    if (type == ChatMessageType.bot) {
      return GestureDetector(
        onLongPress: () {
          final ttsProvider = context.read<TextToSpeechProvider>();
          if (ttsProvider.isSpeaking) {
            ttsProvider.stopSpeaking();
          } else {
            ttsProvider.speak(text);
          }
        },
        child: RawIndividualMessage(text: text),
      );
    } else {
      return RawIndividualMessage(text: text);
    }
  }
}

class RawIndividualMessage extends StatelessWidget {
  const RawIndividualMessage({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
