
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
    var dialog = context.widget as ExtractDialog;
    return AlertDialog(
      title: const Text("Text Found"),
      content: Column(
        children: [
          Text("Coded Number: ${dialog.codedNumber}"),
          const Spacer(),
          Text("Mark: ${dialog.mark}"),
          const Spacer(),
          ElevatedButton(onPressed: () {}, child: const Text("Save"))
        ],
      ),
    );
  }
}


