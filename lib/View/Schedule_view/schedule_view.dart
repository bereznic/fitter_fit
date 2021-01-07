import 'package:fitter_fit/Common_Widgets/drawer_widget.dart';
import 'package:fitter_fit/View/Schedule_view/schedule_list.dart';
import 'package:fitter_fit/View/Schedule_view/create_meeting_button.dart';
import 'package:fitter_fit/constants.dart';
import 'package:flutter/material.dart';

class ScheduleView extends StatefulWidget {
  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  DateTime date = DateTime.now();
  final dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: createMeetingButton(context),
      drawer: DrawerWidget(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  setState(() {
                    date = date.subtract(Duration(days: 1));
                  });
                },
                iconSize: height(context) * 0.06,
                icon: Icon(Icons.arrow_left_outlined),
              ),
              InkWell(
                child: Text(
                  "${date.day}.${date.month}.${date.year}",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
                onTap: () async {
                  await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030))
                      .then((value) {
                    setState(() {
                      if (value != null) date = value;
                    });
                  });
                },
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    date = date.add(Duration(days: 1));
                  });
                },
                iconSize: height(context) * 0.06,
                icon: Icon(Icons.arrow_right_outlined),
              ),
            ],
          ),
          spacer(height(context) * 0.15),
          ScheduleList(
            date: date,
          ),
        ],
      ),
    );
  }
}
