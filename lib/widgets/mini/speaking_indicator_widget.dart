// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../../providers/text_to_speech_provider.dart';

class SpeakingIndicatorWidget extends StatelessWidget {
  const SpeakingIndicatorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.watch<TextToSpeechProvider>().isSpeaking,
      child: Container(
        color: Colors.amber,
        width: MediaQuery.of(context).size.width / 2.5,
        height: 50,
        child: Row(
          children: [
            const Expanded(
              child: LoadingIndicator(
                indicatorType: Indicator.lineScalePulseOutRapid,
              ),
            ),
            IconButton(
              onPressed: (() {
                context.read<TextToSpeechProvider>().stopSpeaking();
              }),
              icon: const Icon(
                Icons.close,
              ),
            )
          ],
        ),
      ),
    );
  }
}
