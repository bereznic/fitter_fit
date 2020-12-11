import 'package:fitter_fit/Services/schedule_service.dart';
import 'package:fitter_fit/View/Schedule_view/discard_meeting_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateMeetingDialog extends StatefulWidget {
  @override
  _CreateMeetingDialogState createState() => _CreateMeetingDialogState();
}

class _CreateMeetingDialogState extends State<CreateMeetingDialog> {
  @override
  Widget build(BuildContext context) {
    final scheduleService =
        Provider.of<ScheduleService>(context, listen: false);
    final discardedMeeting = context.select<ScheduleService, int>(
        (discardedProvider) => discardedProvider.discarded);
    return AlertDialog(
      title: Text("New meeting"),
      actions: [
        FlatButton.icon(
          icon: Icon(Icons.cancel),
          label: Text("Cancel"),
          onPressed: () {},
        ),
        FlatButton.icon(
          onPressed: () async {},
          icon: Icon(Icons.send),
          label: Text("Add meeting"),
        )
      ],
    );
  }
}
