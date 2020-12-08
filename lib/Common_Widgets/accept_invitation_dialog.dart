import 'package:fitter_fit/Entity/invitation_entity.dart';
import 'package:fitter_fit/Services/invitations_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AcceptInvitationDialog extends StatefulWidget {
  final InvitationEntity invitationEntity;

  const AcceptInvitationDialog({Key key, this.invitationEntity})
      : super(key: key);
  @override
  _AcceptInvitationDialogState createState() => _AcceptInvitationDialogState();
}

class _AcceptInvitationDialogState extends State<AcceptInvitationDialog> {
  @override
  Widget build(BuildContext context) {
    final invitationsService =
        Provider.of<InvitationsService>(context, listen: false);
    return AlertDialog(
      title: Text("Accept invitation?"),
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
                  .acceptInvitation(widget.invitationEntity)
                  .then((value) {
                if (value == 'success') Navigator.pop(context);
              });
            },
            icon: Icon(Icons.check),
            label: Text("Confirm"))
      ],
    );
  }
}
