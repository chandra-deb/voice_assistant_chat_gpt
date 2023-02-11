// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_chat_gpt/providers/input_button_provider.dart';
import 'package:voice_chat_gpt/providers/settings_provider.dart';
import 'package:voice_chat_gpt/widgets/micro/mic_widget.dart';
import 'package:voice_chat_gpt/widgets/micro/text_input_widget.dart';

import '../micro/close_response_loading_widget.dart';

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
  // final bool _showMic = true;
  // bool _showLoadingResponse = false;

  @override
  void initState() {
    _textController = TextEditingController();
    _focusNode = FocusNode();
    _textController.addListener(listenTextChanges);
    super.initState();
  }

  void listenTextChanges() {
    final inputBtnProvider = context.read<InputButtonProvider>();
    if (_textController.text.isEmpty &&
        inputBtnProvider.isShowLoadingResponse == false) {
      inputBtnProvider.setShowMicTrue();
    } else if (inputBtnProvider.isShowLoadingResponse == false) {
      inputBtnProvider.setIsShowSubmitTrue();
    }
  }

  Future<void> setResponseLoading(String text) async {
    context.read<InputButtonProvider>().setShowLoadingResponseTrue();
    // setState(() {
    //   _showLoadingResponse = true;
    // });

    await widget.addMessage(text);

    // ignore: use_build_context_synchronously
    context.read<InputButtonProvider>().setShowMicTrue();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<SettingsProvider>().appTheme == AppTheme.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextInputWidget(textController: _textController, focusNode: _focusNode),
        Consumer<InputButtonProvider>(
          builder: (context, inputBtnProvider, child) {
            return inputBtnProvider.isShowLoadingResponse
                ? const CloseResponseLoadingWidget()
                : inputBtnProvider.isShowMic || inputBtnProvider.isShowListening
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
                            backgroundColor:
                                isDark ? Colors.pink : Colors.white,
                            padding: const EdgeInsets.all(5),
                          ),
                          onPressed: () async {
                            final text = _textController.text.trim();
                            _textController.clear();
                            _focusNode.unfocus();
                            await setResponseLoading(text);
                          },
                          child: Icon(
                            color: isDark ? Colors.white : Colors.pink,
                            Icons.send,
                            size: 40,
                          ),
                        ),
                      );
          },
        ),
      ],
    );
  }
}
