import 'package:flutter/material.dart';

class FailDialog extends StatefulWidget {
  @override
  _FailDialogState createState() => _FailDialogState();
}

class _FailDialogState extends State<FailDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Something went wrong!"),
      actions: [
        FlatButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.cancel),
          label: Text(""),
        ),
      ],
    );
  }
}
