import 'package:fitter_fit/Common_Widgets/drawer_widget.dart';
import 'package:fitter_fit/View/Schedule_view/create_meeting_button.dart';
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
      floatingActionButton: createMeetingButton(context),
      drawer: DrawerWidget(),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
