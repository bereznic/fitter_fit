// import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitter_fit/Common_Widgets/drawer_widget.dart';
import 'package:fitter_fit/Common_Widgets/invite_clients_floating_action_button.dart';
// import 'package:fitter_fit/Services/firebase_auth_service.dart';
import 'package:fitter_fit/View/Invitations_view/Invitations_sent_view.dart';
import 'package:fitter_fit/View/Invitations_view/invitations_received_view.dart';
// import 'package:fitter_fit/constants.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class TrainerInvitationsView extends StatefulWidget {
  @override
  _TrainerInvitationsViewState createState() => _TrainerInvitationsViewState();
}

class _TrainerInvitationsViewState extends State<TrainerInvitationsView> {
  PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final authService =
    //     Provider.of<FireBaseAuthService>(context, listen: false);

    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(),
      floatingActionButton: inviteClientsFloatingActionButton(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
            label: "Received",
            activeIcon: Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.send_outlined,
              color: Colors.grey,
            ),
            label: "Sent",
            activeIcon: Icon(
              Icons.send_outlined,
              color: Colors.blue,
            ),
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[InvitationsReceivedView(), InvitationsSentView()],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
