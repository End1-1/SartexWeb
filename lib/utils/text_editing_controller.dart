import 'package:flutter/cupertino.dart';

class STextEditingController extends TextEditingController {
  String? previousValue;

  @override
  void notifyListeners() {
    if (previousValue != text) {
      previousValue = text;
      super.notifyListeners();
    }
  }
}