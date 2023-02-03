import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ResponseLoadingWidget extends StatelessWidget {
  const ResponseLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(16),
      child: const SizedBox(
        width: 45,
        child: LoadingIndicator(
          indicatorType: Indicator.ballPulse,
          colors: [Colors.white, Colors.purple, Colors.blueAccent],
          strokeWidth: 2,
        ),
      ),
    );
  }
}
