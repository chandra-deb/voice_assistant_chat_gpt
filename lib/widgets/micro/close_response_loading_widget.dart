import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/conversation_provider.dart';
import '../../providers/input_button_provider.dart';
import '../../providers/settings_provider.dart';

class CloseResponseLoadingWidget extends StatelessWidget {
  const CloseResponseLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<SettingsProvider>().appTheme == AppTheme.dark;

    return SizedBox(
      height: 50,
      width: 70,
      child: ElevatedButton(
        onPressed: () {
          context.read<ConversationProvider>().cancelResponseRequest();
          context.read<InputButtonProvider>().setShowMicTrue();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          backgroundColor: isDark ? Colors.pink : Colors.white,
          padding: const EdgeInsets.all(5),
        ),
        // child: const LoadingIndicator(
        //   indicatorType: Indicator.ballSpinFadeLoader,
        //   colors: [Colors.red, Colors.purple, Colors.blueAccent],
        //   strokeWidth: 2,
        // ),
        child: Icon(
          Icons.close,
          color: isDark ? Colors.white : Colors.pink,
          size: 40,
        ),
      ),
    );
  }
}
