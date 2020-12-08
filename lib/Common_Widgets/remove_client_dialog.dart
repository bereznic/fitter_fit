import 'package:fitter_fit/Entity/user_entity.dart';
import 'package:fitter_fit/Services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RemoveClientDialog extends StatefulWidget {
  final UserEntity trainer;
  final UserEntity client;

  const RemoveClientDialog({Key key, this.trainer, this.client})
      : super(key: key);
  @override
  _RemoveClientDialogState createState() => _RemoveClientDialogState();
}

class _RemoveClientDialogState extends State<RemoveClientDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Remove client?"),
      content: Text(widget.client.name),
      actions: [
        FlatButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.cancel),
          label: Text("No"),
        ),
        FlatButton.icon(
          label: Text("Yes"),
          onPressed: () async {
            final fireStoreService =
                Provider.of<FireStoreService>(context, listen: false);
            await fireStoreService.removeClient(
                widget.trainer, widget.client.uid);
            Navigator.pop(context);
          },
          icon: Icon(Icons.check),
        )
      ],
    );
  }
}
