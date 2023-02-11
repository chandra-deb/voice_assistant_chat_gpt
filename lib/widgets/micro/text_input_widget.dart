// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/settings_provider.dart';

class TextInputWidget extends StatelessWidget {
  final TextEditingController textController;
  final FocusNode focusNode;
  const TextInputWidget({
    Key? key,
    required this.textController,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<SettingsProvider>().appTheme == AppTheme.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 50,
      decoration: BoxDecoration(
        color: isDark
            ? const Color.fromARGB(115, 49, 48, 48)
            : Colors.grey.shade200,
        border: Border.all(width: 0.1, color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      width: MediaQuery.of(context).size.width - 130,
      child: TextField(
        cursorColor: Colors.grey.shade500,
        decoration: InputDecoration(
          hintText: 'Ask Me Anything',
          hintStyle: TextStyle(color: isDark ? Colors.white : Colors.grey),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          border: InputBorder.none,
        ),
        focusNode: focusNode,
        controller: textController,
      ),
    );
  }
}
