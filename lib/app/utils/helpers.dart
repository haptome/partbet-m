import 'package:flutter/material.dart';

class LabeledController {
  LabeledController({
    required this.label,
    required this.controller,
    this.focusNode,
  });

  String label;
  final TextEditingController controller;
  final FocusNode? focusNode;
  String? errorText;
}

String camelCaseToSpacedWords(String camelCaseStr) {
  // Insert a space before all capital letters and trim whitespace
  final spacedStr = camelCaseStr.replaceAllMapped(
    RegExp(r'(?<=[a-z])[A-Z]'),
    (match) => ' ${match.group(0)}',
  );

  // Capitalize the first letter
  return spacedStr.isNotEmpty
      ? spacedStr[0].toUpperCase() + spacedStr.substring(1)
      : spacedStr;
}
