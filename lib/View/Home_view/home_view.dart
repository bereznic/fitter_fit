// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitter_fit/Common_Widgets/drawer_widget.dart';
// import 'package:fitter_fit/Entity/schedule_entity.dart';
// import 'package:fitter_fit/Entity/user_entity.dart';
// import 'package:fitter_fit/Services/firebase_auth_service.dart';
// import 'package:fitter_fit/Services/firestore_service.dart';
// import 'package:fitter_fit/Services/schedule_service.dart';
import 'package:fitter_fit/View/Schedule_view/schedule_list.dart';
import 'package:fitter_fit/View/Home_view/welcome_user.dart';
import 'package:fitter_fit/constants.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            WelcomeUser(),
            spacer(height(context) * 0.1),
            Expanded(child: ScheduleList(date: DateTime.now())),
            // FlatButton.icon(
            //     onPressed: () {
            //       navigateTo(context, 'ScheduleView');
            //     },
            //     icon: Icon(Icons.arrow_forward_outlined),
            //     label: Text("See full schedule")),
          ],
        ),
      ),
    );
  }
}
