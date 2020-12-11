import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitter_fit/Entity/schedule_entity.dart';
import 'package:fitter_fit/Services/schedule_service.dart';
import 'package:fitter_fit/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScheduleList extends StatefulWidget {
  @override
  _HomeScheduleListState createState() => _HomeScheduleListState();
}

class _HomeScheduleListState extends State<HomeScheduleList> {
  @override
  Widget build(BuildContext context) {
    final scheduleService =
        Provider.of<ScheduleService>(context, listen: false);
    return StreamBuilder(
      stream: scheduleService.getTodaySchedule(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Can't load the schedule!");
        }
        if (snapshot.connectionState == ConnectionState.waiting)
          return Text("Waiting for schedule to load.");
        if (snapshot.data.docs.length == 0)
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Schedule empty."),
                ],
              ),
            ),
          );
        return new ListView.builder(
          itemCount: snapshot.data.docs.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            DocumentSnapshot activitySnapshot = snapshot.data.docs[index];
            ScheduleEntity activityEntity = ScheduleEntity()
                .toScheduleEntity(activitySnapshot.id, activitySnapshot.data());
            DateTime activityDate = stringToDate(activityEntity.date);
            return Column(
              children: [
                Text(
                  "${activityDate.hour}:${activityDate.minute}",
                  style: TextStyle(fontSize: height(context) * 0.02),
                ),
                Container(
                  height: height(context) * 0.2,
                  width: width(context) * 0.6,
                  child: Card(
                      elevation: 10.0,
                      color: Colors.white,
                      child: Center(child: Text(activityEntity.name))),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
