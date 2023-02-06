import 'package:flutter/cupertino.dart';

class InputButtonProvider extends ChangeNotifier {
  bool _isShowMic = true;
  bool _isShowListening = false;
  bool _isShowLoadingResponse = false;
  bool _isShowSubmit = false;

  bool get isShowMic => _isShowMic;
  bool get isShowListening => _isShowListening;
  bool get isShowLoadingResponse => _isShowLoadingResponse;
  bool get isShowSubmit => _isShowSubmit;

  void setShowMicTrue() {
    _isShowMic = true;
    _isShowListening = false;
    _isShowLoadingResponse = false;
    _isShowSubmit = false;
    notifyListeners();
  }

  void setShowIsListeningTrue() {
    _isShowMic = false;
    _isShowListening = true;
    _isShowLoadingResponse = false;
    _isShowSubmit = false;
    notifyListeners();
  }

  void setShowLoadingResponseTrue() {
    _isShowMic = false;
    _isShowListening = false;
    _isShowLoadingResponse = true;
    _isShowSubmit = false;
    notifyListeners();
  }

  void setIsShowSubmitTrue() {
    _isShowMic = false;
    _isShowListening = false;
    _isShowLoadingResponse = false;
    _isShowSubmit = true;
    notifyListeners();
  }
}
