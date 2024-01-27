import "package:flutter/material.dart";
import 'package:flutter/services.dart';

class Keyboard extends StatelessWidget {
  final Function(String) onKeyPress;

  Keyboard({required this.onKeyPress});

  @override
  Widget build(BuildContext context) {
    // Adjust the key rows to match the QWERTY layout
    List<Widget> keyRows = [
      // Top row keys
      TextKeyRow(
          keys: ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
          onKeyPress: onKeyPress),
      // Second row keys, starts with an indentation
      TextKeyRow(
          keys: ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
          onKeyPress: onKeyPress,
          startPadding: 2),
      // Third row keys, also starts with an indentation
      TextKeyRow(
          keys: ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
          onKeyPress: onKeyPress,
          startPadding: 4),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: keyRows,
    );
  }
}

class TextKeyRow extends StatelessWidget {
  final List<String> keys;
  final Function(String) onKeyPress;
  final int startPadding; // Number of empty spaces to add before the keys

  const TextKeyRow({
    Key? key,
    required this.keys,
    required this.onKeyPress,
    this.startPadding = 0, // Default to no padding if not provided
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> rowChildren = [];

    // If there's padding, add empty boxes at the start of the row
    for (int i = 0; i < startPadding; i++) {
      rowChildren.add(Expanded(child: SizedBox()));
    }

    // Add keys to the row
    rowChildren.addAll(keys.map((key) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton(
            child: Text(key, style: TextStyle(fontSize: 20)),
            onPressed: () => onKeyPress(key),
          ),
        ),
      );
    }).toList());

    return Row(children: rowChildren);
  }
}
