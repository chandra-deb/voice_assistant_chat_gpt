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
  bool _showLoadingResponse = false;

  @override
  void initState() {
    _textController = TextEditingController();
    _focusNode = FocusNode();
    _textController.addListener(listenTextChanges);
    super.initState();
  }

  void listenTextChanges() {
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextInputWidget(textController: _textController, focusNode: _focusNode),
        _showLoadingResponse
            ? const ResponseLoadingWidget()
            : _showMic
                ? MicWidget(
                    addMessage: setResponseLoading,
                  )
                : SizedBox(
                    height: 50,
                    width: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(5),
                      ),
                      onPressed: () async {
                        final text = _textController.text.trim();
                        _textController.clear();
                        _focusNode.unfocus();
                        await setResponseLoading(text);
                      },
                      child: const Icon(
                        color: Colors.pink,
                        Icons.send,
                        size: 40,
                      ),
                    ),
                  ),
      ],
    );
  }

  Future<void> setResponseLoading(String text) async {
    setState(() {
      _showLoadingResponse = true;
    });
    await widget.addMessage(text);
    setState(() {
      _showLoadingResponse = false;
    });
  }
}
