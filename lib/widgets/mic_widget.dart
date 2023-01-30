// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../providers/speech_to_text_provider.dart';

class MicWidget extends StatelessWidget {
  const MicWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isListening = context.select(
      (SpeechToTextProvider spt) => spt.isListening,
    );
    return Visibility(
      // visible: !isLoading,
      child: Container(
        color: botBackgroundColor,
        child: IconButton(
            iconSize: 40,
            icon: Icon(
              Icons.mic,
              color: isListening
                  ? Colors.red
                  : const Color.fromRGBO(142, 142, 160, 1),
            ),
            onPressed: () async {
              // If not yet listening for speech start, otherwise stop
              final spt = context.read<SpeechToTextProvider>();
              if (!isListening) {
                await spt.startListening();
              } else {
                await spt.stopListening();
              }
            }),
      ),
    );
  }
}
