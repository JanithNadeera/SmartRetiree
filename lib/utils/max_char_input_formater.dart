import 'package:flutter/services.dart';

class MaxCharTextInputFormater extends TextInputFormatter {
  final int maxChars;
  final ValueChanged<int> currentLength;

  MaxCharTextInputFormater({
    required this.maxChars,
    required this.currentLength,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    int count = 0;
    if (newValue.text.isEmpty) {
      count = 0;
    } else {
      count = newValue.text.length;
    }
    if (count > maxChars) {
      return oldValue;
    }
    currentLength.call(count);
    return newValue;
  }
}
