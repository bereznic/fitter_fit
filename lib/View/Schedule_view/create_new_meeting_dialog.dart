import 'package:fitter_fit/Entity/user_entity.dart';
import 'package:fitter_fit/Services/firestore_service.dart';
import 'package:fitter_fit/View/Schedule_view/discard_meeting_dialog.dart';
import 'package:fitter_fit/View/Schedule_view/multi_select_clients_provider.dart';
import 'package:fitter_fit/View/Schedule_view/select_clients_dialog.dart';
import 'package:fitter_fit/View/Schedule_view/selected_clients_chip_display.dart';
import 'package:fitter_fit/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:date_time_picker/date_time_picker.dart';

class CreateMeetingDialog extends StatefulWidget {
  @override
  _CreateMeetingDialogState createState() => _CreateMeetingDialogState();
}

class _CreateMeetingDialogState extends State<CreateMeetingDialog> {
  final nameController = TextEditingController();
  final dateTimeController = TextEditingController();
  String value;
  String key;
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    // final scheduleService =
    //     Provider.of<ScheduleService>(context, listen: false);
    final fireStoreService =
        Provider.of<FireStoreService>(context, listen: false);
    return AlertDialog(
      scrollable: true,
      title: Text("New activity"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            controller: nameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                labelText: "Activity name",
                icon: Icon(Icons.description_outlined)),
          ),
          DateTimePicker(
            controller: dateTimeController,
            type: DateTimePickerType.dateTimeSeparate,
            firstDate: now,
            lastDate: DateTime(2100),
            icon: Icon(Icons.event),
            dateHintText: "Date",
            timeHintText: "Time",
          ),
          SelectedClientsChipDisplay(),
          StreamBuilder(
            stream: fireStoreService.getUserDocument(currentUserId),
            builder: (context, userSnapshot) {
              if (userSnapshot.hasError) return Text("Error loading users");
              if (userSnapshot.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator();
              UserEntity userData = userSnapshot.data;
              if (userData.clients.isNotEmpty) {
                return FlatButton.icon(
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
                );
              }
              return Container();
            },
          )
        ],
      ),
      actions: [
        FlatButton.icon(
          icon: Icon(Icons.cancel),
          label: Text("Cancel"),
          onPressed: () async {
            print(dateTimeController.text);
            showDialog(context: context, builder: (_) => DiscardMeetingDialog())
                .then((discarded) {
              if (discarded == true) Navigator.pop(context, true);
            });
          },
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
