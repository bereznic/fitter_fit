import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitter_fit/Common_Widgets/signout_dialog.dart';
import 'package:fitter_fit/Entity/user_entity.dart';
import 'package:fitter_fit/Services/firebase_auth_service.dart';
import 'package:fitter_fit/Services/firestore_service.dart';
import 'package:fitter_fit/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
//   @override
//   _DrawerWidgetState createState() => _DrawerWidgetState();
// }

// class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final fireStore = Provider.of<FireStoreService>(context, listen: false);
    return StreamBuilder(
        //GET USER DOCUMENT E STREAM DE AIA NU FOLOSIM GET CURRENT USER din auth service
        stream:
            fireStore.getUserDocument(FirebaseAuth.instance.currentUser.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text("Something went wrong!"));
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          UserEntity userData = snapshot.data;
          return Drawer(
            child: Column(
              children: <Widget>[
                DrawerHeader(
                  child: Text(userData.name),
                ),
                ListTile(
                  title: Text("Home"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacementNamed('HomeView');
                  },
                ),
                userData.userType == trainer
                    ? ListTile(
                        title: Text("My clients"),
                        onTap: () {
                          Navigator.pop(context);
                          navigateTo(context, 'ClientsView');
                        },
                      )
                    : Container(),
                ListTile(
                  title: Text("Schedule"),
                  onTap: () {
                    Navigator.pop(context);
                    navigateTo(context, 'ScheduleView');
                  },
                ),
                ListTile(
                  title: Text("Invitations"),
                  onTap: () {
                    Navigator.pop(context);
                    navigateTo(context, 'InvitationsView');
                  },
                ),
                Expanded(
                  child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: ListTile(
                        title: Text("Sign out"),
                        tileColor: Colors.red[300],
                        onTap: () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (_) => SignoutDialog(),
                          );
                        },
                      )),
                )
              ],
            ),
          );
        });
  }
}
