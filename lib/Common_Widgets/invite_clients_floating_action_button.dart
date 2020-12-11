import 'package:fitter_fit/Common_Widgets/invite_dialog.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Widget inviteClientsFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      showDialog(
        context: context,
        builder: (_) => InviteDialog(),
      ).then((result) {
        Flushbar(
          messageText: Text("rezultatul este: $result"),
          duration: Duration(seconds: 2),
        )..show(context);
      });
    },
    backgroundColor: Colors.green,
    child: Icon(Icons.add),
  );
}
