import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final String trainer = "trainer";
final String client = "client";
final String clientId = 'clientId';
final String trainerId = 'trainerId';
final String usersCollection = "users";
final String date = "date";
final String invitationsCollection = "invitations";
final String scheduleCollection = "schedule";
// final String uid = "uid";
final String email = "email";
final String name = "name";
final String userType = "userType";
final String clients = "clients";

final String success = 'success';
final String invitationSentAlready = 'invitationSentAlready';
final String alreadyClient = 'alreadyClient';
final String userNotFound = 'userNotFound';

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

void navigateTo(BuildContext context, String routeName) {
  Navigator.of(context).pushNamed(routeName);
}

DateTime stringToDate(String dateTime) {
  return DateTime.parse(dateTime);
}

String dateToString(DateTime dateTime) {
  return dateTime.toString();
}

final currentUserId = FirebaseAuth.instance.currentUser.uid;

Widget spacer(double height) {
  return SizedBox(
    height: height,
  );
}
