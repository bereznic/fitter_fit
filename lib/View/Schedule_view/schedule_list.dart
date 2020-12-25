import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitter_fit/Entity/schedule_entity.dart';
import 'package:fitter_fit/Entity/user_entity.dart';
import 'package:fitter_fit/Services/firestore_service.dart';
import 'package:fitter_fit/Services/Schedule_service/schedule_service.dart';
import 'package:fitter_fit/View/Schedule_view/create_new_meeting_dialog.dart';
import 'package:fitter_fit/View/Schedule_view/remove_meeting_dialog.dart';
import 'package:fitter_fit/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleList extends StatefulWidget {
  final DateTime date;
  ScheduleList({Key key, this.date}) : super(key: key);
  @override
  _ScheduleListState createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  @override
  Widget build(BuildContext context) {
    final scheduleService =
        Provider.of<ScheduleService>(context, listen: false);
    final fireStoreService =
        Provider.of<FireStoreService>(context, listen: false);
    return StreamBuilder(
      initialData: "Loading",
      stream: scheduleService.getScheduleByDate(widget.date),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Can't load the schedule!");
        }
        if (snapshot.connectionState == ConnectionState.waiting)
          return Text("Waiting for schedule to load.");
        if (snapshot.data.docs.length == 0)
          return Center(child: Text("No activities for today."));
        return Expanded(
          child: new ListView.builder(
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              DocumentSnapshot activitySnapshot = snapshot.data.docs[index];
              ScheduleEntity activityEntity = ScheduleEntity().toScheduleEntity(
                  activitySnapshot.id, activitySnapshot.data());
              DateTime activityDate = stringToDate(activityEntity.date);
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${activityDate.hour}:${activityDate.minute}",
                    style: TextStyle(fontSize: height(context) * 0.02),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: height(context) * 0.4,
                      width: width(context) * 0.6,
                      child: Card(
                          elevation: 10.0,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(Icons.cancel_outlined),
                                  color: Colors.red,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => RemoveMeetingDialog(
                                        meeting: activityEntity,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Text(activityEntity.name),
                              FutureBuilder(
                                future: fireStoreService.getUserDocumentFuture(
                                    activityEntity.owner),
                                builder: (context, ownerSnapshot) {
                                  if (ownerSnapshot.hasError) {
                                    return Text(
                                        "can't load meeting's owner name");
                                  }
                                  if (ownerSnapshot.connectionState ==
                                      ConnectionState.waiting)
                                    return Text("loading owner's name");
                                  UserEntity owner = ownerSnapshot.data;
                                  return Text("owner: " + owner.name);
                                },
                              ),
                              Text(activityEntity.description),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: FlatButton.icon(
                                    icon: Icon(
                                      Icons.edit_outlined,
                                    ),
                                    label: Text("Edit"),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => CreateMeetingDialog(
                                          meetingEntity: activityEntity,
                                        ),
                                      );
                                    },
                                  ))
                            ],
                          )),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
