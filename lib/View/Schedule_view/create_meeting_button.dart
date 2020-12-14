import 'package:fitter_fit/View/Schedule_view/create_new_meeting_dialog.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Widget createMeetingButton(BuildContext context) {
  return FloatingActionButton(
      onPressed: () async {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => CreateMeetingDialog(),
        ).then((discarded) {
          if (discarded == true) {
            Flushbar(
              messageText: Text("Meeting discarded"),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.orange[200],
            )..show(context);
          }
        });
      },
      child: Icon(Icons.add));
}
