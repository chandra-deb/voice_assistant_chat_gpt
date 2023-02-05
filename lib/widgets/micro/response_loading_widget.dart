import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ResponseLoadingWidget extends StatelessWidget {
  const ResponseLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 70,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(5),
        ),
        child: const LoadingIndicator(
          indicatorType: Indicator.ballSpinFadeLoader,
          colors: [Colors.red, Colors.purple, Colors.blueAccent],
          strokeWidth: 2,
        ),
      ),
    );
  }
}
