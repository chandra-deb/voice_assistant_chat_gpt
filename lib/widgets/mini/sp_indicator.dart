import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../../providers/text_to_speech_provider.dart';

class SPIndicatorWidget extends StatelessWidget {
  const SPIndicatorWidget({
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                // width: MediaQuery.of(context).size.width / 3,
                height: 50,
                child: Expanded(
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
                ),
              )
            : const Text(
                'Friendly',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.pink, fontSize: 50),
              ));
  }
}