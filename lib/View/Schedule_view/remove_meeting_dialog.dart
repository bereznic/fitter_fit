import 'package:fitter_fit/Entity/schedule_entity.dart';
import 'package:fitter_fit/Services/Schedule_service/schedule_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RemoveMeetingDialog extends StatefulWidget {
  final ScheduleEntity meeting;
  RemoveMeetingDialog({Key key, this.meeting}) : super(key: key);
  @override
  _RemoveMeetingDialogState createState() => _RemoveMeetingDialogState();
}

class _RemoveMeetingDialogState extends State<RemoveMeetingDialog> {
  @override
  Widget build(BuildContext context) {
    final scheduleService =
        Provider.of<ScheduleService>(context, listen: false);
    return AlertDialog(
      title: Text("Remove meeting?"),
      actions: [
        FlatButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.cancel_outlined),
            label: Text("Cancel")),
        FlatButton.icon(
            onPressed: () {
              scheduleService
                  .removeMeeting(widget.meeting)
                  .then((value) => Navigator.pop(context));
            },
            icon: Icon(Icons.check),
            label: Text("Confirm")),
      ],
    );
  }
}
