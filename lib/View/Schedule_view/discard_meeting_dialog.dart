import 'package:fitter_fit/Services/Schedule_service/multi_select_clients_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiscardMeetingDialog extends StatefulWidget {
  @override
  _DiscardMeetingDialogState createState() => _DiscardMeetingDialogState();
}

class _DiscardMeetingDialogState extends State<DiscardMeetingDialog> {
  @override
  Widget build(BuildContext context) {
    // final scheduleService =
    //     Provider.of<ScheduleService>(context, listen: false);
    final selectedClients =
        Provider.of<MultiSelectClients>(context, listen: false);
    return AlertDialog(
      title: Text("Discard meeting?"),
      content: Text("Progress won't be saved"),
      actions: [
        FlatButton.icon(
          label: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context, false);
          },
          icon: Icon(Icons.cancel),
        ),
        FlatButton.icon(
          label: Text("Confirm"),
          onPressed: () {
            selectedClients.deselectAllClients();
            Navigator.pop(context, true);
          },
          icon: Icon(Icons.check),
        )
      ],
    );
  }
}
