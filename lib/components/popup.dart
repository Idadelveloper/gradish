
import 'package:flutter/material.dart';

class ExtractDialog extends StatefulWidget {
  const ExtractDialog({Key? key, required this.codedNumber, required this.mark}) : super(key: key);
  final String codedNumber;
  final String mark;

  @override
  State<ExtractDialog> createState() => _ExtractDialogState();
}

class _ExtractDialogState extends State<ExtractDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Text Found"),
      content: Column(
        children: [
          Text("Coded Number: "),
          Spacer(),
          Text("Mark: "),
          Spacer(),
          ElevatedButton(onPressed: () {}, child: Text("Continue"))
        ],
      ),
    );
  }
}


