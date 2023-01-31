// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:voice_chat_gpt/widgets/micro/text_input_widget.dart';

import '../micro/mic_widget.dart';

class InputBarWidget extends StatefulWidget {
  final void Function(String text) addMessage;

  const InputBarWidget({
    Key? key,
    required this.addMessage,
  }) : super(key: key);

  @override
  State<InputBarWidget> createState() => _InputBarWidgetState();
}

class _InputBarWidgetState extends State<InputBarWidget> {
  late final TextEditingController _textController;
  late final FocusNode _focusNode;
  bool showMic = true;

  @override
  void initState() {
    _textController = TextEditingController();
    _focusNode = FocusNode();
    _textController.addListener(listenTextChanges);
    super.initState();
  }

  void listenTextChanges() {
    print(_textController.text);
    if (_textController.text.isEmpty) {
      setState(() {
        showMic = true;
      });
    } else {
      setState(() {
        showMic = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextInputWidget(textController: _textController, focusNode: _focusNode),
        showMic
            ? MicWidget(
                addMessage: widget.addMessage,
              )
            : IconButton(
                onPressed: () {
                  widget.addMessage(_textController.text);
                  _textController.clear();
                  _focusNode.unfocus();
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.blueAccent,
                  size: 40,
                ),
              ),
      ],
    );
  }
}
