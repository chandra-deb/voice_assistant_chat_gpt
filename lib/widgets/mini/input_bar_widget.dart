// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:voice_chat_gpt/widgets/micro/text_input_widget.dart';

import '../micro/mic_widget.dart';
import '../micro/response_loading_widget.dart';

class InputBarWidget extends StatefulWidget {
  final Future<void> Function(String text) addMessage;

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
  bool _showMic = true;
  bool _isLoadingResponse = false;

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
        _showMic = true;
      });
    } else {
      setState(() {
        _showMic = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextInputWidget(textController: _textController, focusNode: _focusNode),
        _isLoadingResponse
            ? const ResponseLoadingWidget()
            : _showMic
                ? MicWidget(
                    addMessage: setResponseLoading,
                  )
                : IconButton(
                    onPressed: () async {
                      final text = _textController.text.trim();
                      _textController.clear();
                      _focusNode.unfocus();
                      await setResponseLoading(text);
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

  Future<void> setResponseLoading(String text) async {
    setState(() {
      _isLoadingResponse = true;
    });
    await widget.addMessage(text);
    setState(() {
      _isLoadingResponse = false;
    });
  }
}
