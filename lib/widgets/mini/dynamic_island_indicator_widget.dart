// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../../providers/text_to_speech_provider.dart';
import 'dynamic_island.dart';

class DynamicIslandIndicatorWidget extends StatelessWidget {
  const DynamicIslandIndicatorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ttsProvider = context.watch<TextToSpeechProvider>();

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: ttsProvider.isSpeaking
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              // width: MediaQuery.of(context).size.width / 3,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  LoadingIndicator(
                    colors: [
                      // Colors.pink.shade300,
                      Colors.pink,
                      // Colors.pink.shade300
                    ],
                    indicatorType: Indicator.lineScalePulseOutRapid,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  LoadingIndicator(
                    colors: [
                      // Colors.pink.shade300,
                      Colors.pink,
                      // Colors.pink.shade300
                    ],
                    indicatorType: Indicator.lineScalePulseOutRapid,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  LoadingIndicator(
                    colors: [
                      // Colors.pink.shade300,
                      Colors.pink,
                      // Colors.pink.shade300
                    ],
                    indicatorType: Indicator.lineScalePulseOutRapid,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  LoadingIndicator(
                    colors: [
                      // Colors.pink.shade300,
                      Colors.pink,
                      // Colors.pink.shade300
                    ],
                    indicatorType: Indicator.lineScalePulseOutRapid,
                  ),
                ],
              ),
            )
          : const DynamicIsland(),
    );
  }
}
