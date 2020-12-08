import 'package:fitter_fit/Common_Widgets/drawer_widget.dart';
import 'package:fitter_fit/View/Invitations_view/invitations_received_view.dart';
import 'package:flutter/material.dart';

class ClientInvitationsView extends StatefulWidget {
  @override
  _ClientInvitationsViewState createState() => _ClientInvitationsViewState();
}

class _ClientInvitationsViewState extends State<ClientInvitationsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerWidget(),
      body: InvitationsReceivedView(),
    );
  }
}
