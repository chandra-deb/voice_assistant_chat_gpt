// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SpeakingIndicatorWidget extends StatelessWidget {
  final void Function() onClose;
  const SpeakingIndicatorWidget({
    Key? key,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        width: MediaQuery.of(context).size.width / 3,
        // height: 50,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: LoadingIndicator(
                      indicatorType: Indicator.lineScalePulseOutRapid,
                    ),
                  ),
                ),
                Container(
                  color: Colors.black87,
                  width: 2,
                ),
                Center(
                  child: IconButton(
                    onPressed: (() {
                      onClose();
                    }),
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                )
              ],
            ),
            const Text('Speaking'),
          ],
        ),
      ),
    );
  }
}
