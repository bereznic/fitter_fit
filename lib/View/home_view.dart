import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitter_fit/Common_Widgets/drawer_widget.dart';
import 'package:fitter_fit/Entity/user_entity.dart';
import 'package:fitter_fit/Services/firebase_auth_service.dart';
import 'package:fitter_fit/Services/firestore_service.dart';
import 'package:fitter_fit/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final authService =
        Provider.of<FireBaseAuthService>(context, listen: false);
    final fireStore = Provider.of<FireStoreService>(context, listen: false);
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(),
      body: StreamBuilder(
        stream:
            fireStore.getUserDocument(FirebaseAuth.instance.currentUser.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text("Something went wrong!"));
          }
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          UserEntity userData = snapshot.data;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Welcome " + userData.name,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.03),
                ),
                userData.userType != trainer
                    ? FlatButton(
                        onPressed: () async {
                          await fireStore
                              .makeTrainer(await authService.getCurrentUser());
                        },
                        color: Colors.blue,
                        child: Text(
                          "Upgrade to trainer!",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : Container(),
              ],
            ),
          );
        },
      ),
    );
  }
}
