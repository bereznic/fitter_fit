import 'package:fitter_fit/Common_Widgets/invite_dialog.dart';
import 'package:flutter/material.dart';

Widget inviteClientsFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      showDialog(
        context: context,
        builder: (_) => InviteDialog(),
      );
    },
    backgroundColor: Colors.green,
    child: Icon(Icons.add),
  );
}
