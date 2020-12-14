import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitter_fit/Entity/schedule_entity.dart';
import 'package:fitter_fit/constants.dart';
// import 'package:flutter/material.dart';

class ScheduleService {
  CollectionReference usersRefference =
      FirebaseFirestore.instance.collection(usersCollection);
  int discarded = 0;

  Future<void> addSchedule(ScheduleEntity _scheduleEntity) async {
    return usersRefference
        .doc(currentUserId)
        .collection(scheduleCollection)
        .add(_scheduleEntity.scheduleToMap(_scheduleEntity))
        .then((value) async {
      if (_scheduleEntity.guests.isNotEmpty)
        _scheduleEntity.guests.forEach((guest) {
          usersRefference
              .doc(guest)
              .collection(scheduleCollection)
              .add(_scheduleEntity.scheduleToMap(_scheduleEntity));
        });
    });
  }

  Stream<QuerySnapshot> getTodaySchedule() {
    DateTime _now = DateTime.now();
    String startOfToday =
        dateToString(new DateTime(_now.year, _now.month, _now.day, 0, 0));
    String endOfToday =
        dateToString(new DateTime(_now.year, _now.month, _now.day, 23, 59));
    return usersRefference
        .doc(currentUserId)
        .collection(scheduleCollection)
        .where(date, isGreaterThanOrEqualTo: startOfToday)
        .where(date, isLessThanOrEqualTo: endOfToday)
        .snapshots(includeMetadataChanges: true);
  }
}
