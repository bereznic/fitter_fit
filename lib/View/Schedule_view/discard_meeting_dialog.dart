import 'package:fitter_fit/Services/schedule_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiscardMeetingDialog extends StatefulWidget {
  @override
  _DiscardMeetingDialogState createState() => _DiscardMeetingDialogState();
}

class _DiscardMeetingDialogState extends State<DiscardMeetingDialog> {
  @override
  Widget build(BuildContext context) {
    final scheduleService =
        Provider.of<ScheduleService>(context, listen: false);
    return AlertDialog(
      title: Text("Discard meeting?"),
      content: Text("Progress won't be saved"),
      actions: [
        FlatButton.icon(
          label: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.cancel),
        ),
        FlatButton.icon(
          label: Text("Confirm"),
          onPressed: () {},
          icon: Icon(Icons.check),
        )
      ],
    );
  }
}
