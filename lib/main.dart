import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KeyboardDemo(),
    );
  }
}

class KeyboardDemo extends StatefulWidget {
  @override
  _KeyboardDemoState createState() => _KeyboardDemoState();
}

class _KeyboardDemoState extends State<KeyboardDemo> {
  String text = "";

  void _onKeyPress(String keyVal) {
    setState(() {
      if (keyVal == '⌫') {
        if (text.isNotEmpty) {
          text = text.substring(0, text.length - 1);
        }
      } else {
        text += keyVal;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Custom On-Screen Keyboard")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Text(
                text,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(child: Keyboard(onKeyPress: _onKeyPress)),
        ],
      ),
    );
  }
}

class Keyboard extends StatelessWidget {
  final Function(String) onKeyPress;

  Keyboard({required this.onKeyPress});

  @override
  Widget build(BuildContext context) {
    double keyWidth = MediaQuery.of(context).size.width / 10 -
        6 * 2; // screen width / number of keys - padding
    double keyHeight = 48; // fixed height for all keys

    return Column(
      children: [
        KeyRow(
            keys: 'QWERTYUIOP',
            onKeyPress: onKeyPress,
            keyWidth: keyWidth,
            keyHeight: keyHeight),
        Center(
          child: KeyRow(
              keys: 'ASDFGHJKL',
              onKeyPress: onKeyPress,
              keyWidth: keyWidth,
              keyHeight: keyHeight),
        ),
        Center(
          child: KeyRow(
              keys: 'ZXCVBNM',
              onKeyPress: onKeyPress,
              keyWidth: keyWidth,
              keyHeight: keyHeight,
              isLastRow: true),
        ),
      ],
    );
  }
}

class KeyRow extends StatelessWidget {
  final String keys;
  final Function(String) onKeyPress;
  final double keyWidth;
  final double keyHeight;
  final bool isLastRow;

  KeyRow({
    Key? key,
    required this.keys,
    required this.onKeyPress,
    required this.keyWidth,
    required this.keyHeight,
    this.isLastRow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> rowChildren = keys.split('').map((key) {
      return Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          width: keyWidth,
          height: keyHeight,
          child: GestureDetector(
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                alignment: Alignment.bottomCenter,
                child: Text(key, style: TextStyle(fontSize: 20))),
            onTap: () => onKeyPress(key),
          ),
        ),
      );
    }).toList();

    if (isLastRow) {
      rowChildren.add(
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: SizedBox(
            width: keyWidth,
            height: keyHeight,
            child: ElevatedButton(
              child: Icon(Icons.backspace),
              onPressed: () => onKeyPress('⌫'),
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: rowChildren,
    );
  }
}
