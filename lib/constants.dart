import 'package:flutter/material.dart';

final String trainer = "trainer";
final String client = "client";
final String clientId = 'clientId';
final String trainerId = 'trainerId';
final String usersCollection = "users";
final String invitationsCollection = "invitations";
// final String uid = "uid";
final String email = "email";
final String name = "name";
final String userType = "userType";
final String clients = "clients";

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

void navigateTo(BuildContext context, String routeName) {
  Navigator.of(context).pushNamed(routeName);
}
