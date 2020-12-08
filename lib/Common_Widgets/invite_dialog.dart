import 'package:fitter_fit/Common_Widgets/fail_dialog.dart';
import 'package:fitter_fit/Common_Widgets/loading_dialog.dart';
import 'package:fitter_fit/Common_Widgets/success_dialog.dart';
import 'package:fitter_fit/Services/invitations_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InviteDialog extends StatefulWidget {
  @override
  _InviteDialogState createState() => _InviteDialogState();
}

class _InviteDialogState extends State<InviteDialog> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final invitationsService =
        Provider.of<InvitationsService>(context, listen: false);
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Who do you wish to invite?"),
          TextField(
            controller: emailController,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: "Email", prefixIcon: Icon(Icons.email)),
          ),
        ],
      ),
      actions: [
        FlatButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.cancel),
          label: Text("Cancel"),
        ),
        FlatButton.icon(
          onPressed: () async {
            return FutureBuilder(
              future: invitationsService.sendInvitation(emailController.text),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  Navigator.pop(context);
                  return Text("${snapshot.data}");
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == 'success') Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                  return CircularProgressIndicator();
                }
              },
            );
          },
          icon: Icon(Icons.send),
          label: Text("Send"),
        )
      ],
    );
  }
}