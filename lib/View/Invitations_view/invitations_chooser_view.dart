import 'package:fitter_fit/Services/firebase_auth_service.dart';
import 'package:fitter_fit/View/Invitations_view/client_invitation_view.dart';
import 'package:fitter_fit/View/Invitations_view/trainer_invitations_view.dart';
import 'package:fitter_fit/constants.dart';
import 'package:flutter/material.dart';

class InvitationsChooserView extends StatefulWidget {
  @override
  _InvitationsChooserViewState createState() => _InvitationsChooserViewState();
}

class _InvitationsChooserViewState extends State<InvitationsChooserView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FireBaseAuthService().getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Scaffold(
            body: Container(
              child: Text("Something went wrong!"),
            ),
          );
        if (snapshot.connectionState == ConnectionState.waiting)
          return Scaffold(
            body: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        if (snapshot.data.userType == trainer)
          return TrainerInvitationsView();
        else
          return ClientInvitationsView();
      },
    );
  }
}
