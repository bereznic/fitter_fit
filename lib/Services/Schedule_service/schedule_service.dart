import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitter_fit/Entity/schedule_entity.dart';
import 'package:fitter_fit/constants.dart';

class ScheduleService {
  CollectionReference usersRefference =
      FirebaseFirestore.instance.collection(usersCollection);
  int discarded = 0;

  Future<void> addSchedule(ScheduleEntity _scheduleEntity) async {
    return usersRefference
        .doc(currentUserId)
        .collection(scheduleCollection)
        .add(_scheduleEntity.scheduleToMap(_scheduleEntity))
        .then((docRef) async {
      if (_scheduleEntity.guests.isNotEmpty)
        _scheduleEntity.guests.forEach((guest) {
          usersRefference
              .doc(guest)
              .collection(scheduleCollection)
              .doc(docRef.id)
              .set(_scheduleEntity.scheduleToMap(_scheduleEntity));
        });
    });
  }

  Stream<QuerySnapshot> getScheduleByDate(DateTime date) {
    String startOfTheDay =
        dateToString(new DateTime(date.year, date.month, date.day, 0, 0));
    String endOfTheDay =
        dateToString(new DateTime(date.year, date.month, date.day, 23, 59));
    return usersRefference
        .doc(currentUserId)
        .collection(scheduleCollection)
        .where('date', isGreaterThanOrEqualTo: startOfTheDay)
        .where('date', isLessThanOrEqualTo: endOfTheDay)
        .snapshots(includeMetadataChanges: true);
  }

  Future<void> updateMeeting(ScheduleEntity updatedMeeting) {
    List<String> currentGuests;
    return usersRefference
        .doc(currentUserId)
        .collection(scheduleCollection)
        .doc(updatedMeeting.scheduleId)
        .get()
        .then((currentDBMeetingSnapshot) {
      ScheduleEntity currentDBMeeting = ScheduleEntity().toScheduleEntity(
          updatedMeeting.scheduleId, currentDBMeetingSnapshot.data());
      currentGuests = currentDBMeeting.guests;
      updatedMeeting.guests.forEach((guest) async {
        if (currentGuests.contains(guest))
          await usersRefference
              .doc(guest)
              .collection(scheduleCollection)
              .doc(updatedMeeting.scheduleId)
              .update(updatedMeeting.scheduleToMap(updatedMeeting));
        else if (!currentGuests.contains(guest))
          await usersRefference
              .doc(guest)
              .collection(scheduleCollection)
              .doc(updatedMeeting.scheduleId)
              .set(updatedMeeting.scheduleToMap(updatedMeeting));
      });
    }).then((result) {
      currentGuests.forEach((currentGuest) async {
        if (!updatedMeeting.guests.contains(currentGuest))
          await usersRefference
              .doc(currentGuest)
              .collection(scheduleCollection)
              .doc(updatedMeeting.scheduleId)
              .delete();
      });
    }).then((value) {
      return usersRefference
          .doc(currentUserId)
          .collection(scheduleCollection)
          .doc(updatedMeeting.scheduleId)
          .update(updatedMeeting.scheduleToMap(updatedMeeting));
    });
  }

  Future removeMeeting(ScheduleEntity meeting) {
    return usersRefference
        .doc(meeting.owner)
        .collection(scheduleCollection)
        .doc(meeting.scheduleId)
        .delete()
        .then((value) {
      return meeting.guests.forEach((guest) {
        usersRefference
            .doc(guest)
            .collection(scheduleCollection)
            .doc(meeting.scheduleId)
            .delete();
      });
    });
  }
}
