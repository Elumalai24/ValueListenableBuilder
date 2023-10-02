import 'package:flutter/material.dart';

class AppValueNotifier {
  ValueNotifier<List<String>> valueNotifier = ValueNotifier<List<String>>([]);

  void addItem(String value) {
    valueNotifier.value.add(value);
  }
}
