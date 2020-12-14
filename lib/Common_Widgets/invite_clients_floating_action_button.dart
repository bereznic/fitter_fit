import 'package:fitter_fit/Common_Widgets/invite_dialog.dart';
import 'package:fitter_fit/constants.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Widget inviteClientsFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () async {
      showDialog(
        context: context,
        builder: (_) => InviteDialog(),
      ).then((result) {
        Flushbar(
          messageText: Text(result),
          duration: Duration(seconds: 4),
          backgroundColor:
              result == success ? Colors.green[200] : Colors.red[300],
        )..show(context);
      });
    },
    backgroundColor: Colors.green,
    child: Icon(Icons.add),
  );
}
