import 'package:fitter_fit/Services/invitations_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CancelInvitationDialog extends StatefulWidget {
  final String invitationId;

  const CancelInvitationDialog({Key key, this.invitationId}) : super(key: key);
  @override
  _CancelInvitationDialogState createState() => _CancelInvitationDialogState();
}

class _CancelInvitationDialogState extends State<CancelInvitationDialog> {
  @override
  Widget build(BuildContext context) {
    final invitationsService =
        Provider.of<InvitationsService>(context, listen: false);
    return AlertDialog(
      title: Text("Cancel invitation?"),
      actions: [
        FlatButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.cancel_outlined),
            label: Text("Cancel")),
        FlatButton.icon(
            onPressed: () async {
              invitationsService
                  .deleteInvitation(widget.invitationId)
                  .then((value) => Navigator.pop(context));
            },
            icon: Icon(Icons.check),
            label: Text("Confirm"))
      ],
    );
  }
}
