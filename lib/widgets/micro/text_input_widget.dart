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
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(width: 0.1, color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      width: MediaQuery.of(context).size.width - 130,
      child: TextField(
        cursorColor: Colors.grey.shade500,
        decoration: const InputDecoration(
          hintText: 'Ask Me Anything',
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          border: InputBorder.none,
        ),
        focusNode: focusNode,
        controller: textController,
      ),
    );
  }
}
