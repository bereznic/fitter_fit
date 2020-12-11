import 'package:fitter_fit/Common_Widgets/drawer_widget.dart';
import 'package:fitter_fit/View/Schedule_view/create_new_meeting_dialog.dart';
import 'package:flutter/material.dart';

class ScheduleView extends StatefulWidget {
  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => CreateMeetingDialog(),
          );
        },
        child: Icon(Icons.add),
      ),
      drawer: DrawerWidget(),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
