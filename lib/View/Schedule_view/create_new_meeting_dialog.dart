import 'package:fitter_fit/Entity/schedule_entity.dart';
import 'package:fitter_fit/Services/Schedule_service/schedule_service.dart';
import 'package:fitter_fit/View/Schedule_view/discard_meeting_dialog.dart';
import 'package:fitter_fit/Services/Schedule_service/multi_select_clients_provider.dart';
import 'package:fitter_fit/View/Schedule_view/select_clients_dialog.dart';
import 'package:fitter_fit/View/Schedule_view/selected_clients_chip_display.dart';
import 'package:fitter_fit/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:date_time_picker/date_time_picker.dart';

class CreateMeetingDialog extends StatefulWidget {
  final ScheduleEntity meetingEntity;

  CreateMeetingDialog({Key key, this.meetingEntity}) : super(key: key);
  @override
  _CreateMeetingDialogState createState() => _CreateMeetingDialogState();
}

class _CreateMeetingDialogState extends State<CreateMeetingDialog> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final dateTimeController = TextEditingController();
  final descriptionController = TextEditingController();
  bool editMode = false;
  DateTime now = new DateTime.now();
  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    dateTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheduleService =
        Provider.of<ScheduleService>(context, listen: false);
    final selectedClients =
        Provider.of<MultiSelectClients>(context, listen: false);
    ScheduleEntity scheduleEntity = widget.meetingEntity;
    if (scheduleEntity != null) {
      editMode = true;
      selectedClients.selectedClients = widget.meetingEntity.guests;
    }
    if (scheduleEntity == null)
      scheduleEntity =
          new ScheduleEntity(name: null, date: null, description: null);
    return AlertDialog(
      scrollable: true,
      title: editMode == false ? Text("New activity") : Text("Edit activity"),
      content: Form(
        key: _formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          TextFormField(
            controller: nameController..text = scheduleEntity.name,
            onSaved: (value) {
              nameController.text = value;
            },
            // onSaved: ,
            // controller: nameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                labelText: "Activity name",
                icon: Icon(Icons.description_outlined)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          DateTimePicker(
            controller: dateTimeController..text = scheduleEntity.date,
            onSaved: (value) {
              widget.meetingEntity.date = value;
            },
            // controller: dateTimeController,
            type: DateTimePickerType.dateTimeSeparate,
            firstDate: now,
            lastDate: DateTime(2100),
            icon: Icon(Icons.event),
            dateHintText: "Date",
            timeHintText: "Time",
            validator: (value) {
              if (value.length < 13) return "Select date and time";
              return null;
            },
          ),
          spacer(height(context) * 0.03),
          TextFormField(
            controller: descriptionController
              ..text = scheduleEntity.description,
            onSaved: (value) {
              widget.meetingEntity.description = value;
            },
            maxLines: 2,
            // controller: notesController,
            autocorrect: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Description/comments",
              icon: Icon(Icons.note),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          SelectedClientsChipDisplay(),
          FlatButton.icon(
            icon: Icon(Icons.add),
            label: Text("Select clients"),
            onPressed: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return SelectClientsDialog();
                  });
            },
          )
        ]),
      ),
      actions: [
        FlatButton.icon(
          icon: Icon(Icons.cancel),
          label: Text("Cancel"),
          onPressed: () async {
            print(nameController.text);
            showDialog(context: context, builder: (_) => DiscardMeetingDialog())
                .then((discarded) {
              if (discarded == true) Navigator.pop(context, true);
            });
          },
        ),
        FlatButton.icon(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                ScheduleEntity _newSchedule = new ScheduleEntity(
                    date: dateTimeController.text,
                    name: nameController.text,
                    guests: selectedClients.selectedClients,
                    description: descriptionController.text,
                    owner: currentUserId);
                if (editMode == false)
                  scheduleService.addSchedule(_newSchedule).then((result) {
                    selectedClients.deselectAllClients();
                    Navigator.pop(context);
                  });
                else if (editMode == true) {
                  _newSchedule.scheduleId = widget.meetingEntity.scheduleId;
                  scheduleService.updateMeeting(_newSchedule).then((value) {
                    selectedClients.deselectAllClients();
                    Navigator.pop(context);
                  });
                }
              }
            },
            icon: editMode == false
                ? Icon(Icons.send)
                : Icon(Icons.update_outlined),
            label: editMode == false
                ? Text("Add meeting")
                : Text("Update meeting"))
      ],
    );
  }
}
