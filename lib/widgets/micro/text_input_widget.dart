// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

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
    return Container(
      color: Colors.pink,
      width: MediaQuery.of(context).size.width - 130,
      child: TextField(
        decoration: const InputDecoration(
          label: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Ask me anything!',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        focusNode: focusNode,
        controller: textController,
      ),
    );
  }
}
