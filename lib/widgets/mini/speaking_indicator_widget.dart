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
        color: Colors.amber,
        width: MediaQuery.of(context).size.width / 2.5,
        height: 50,
        child: Row(
          children: [
            const Expanded(
              child: LoadingIndicator(
                indicatorType: Indicator.lineScaleParty,
              ),
            ),
            IconButton(
              onPressed: (() {
                onClose();
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
