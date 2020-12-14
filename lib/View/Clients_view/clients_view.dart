import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitter_fit/Common_Widgets/drawer_widget.dart';
import 'package:fitter_fit/Common_Widgets/invite_clients_floating_action_button.dart';
import 'package:fitter_fit/View/Clients_view/remove_client_dialog.dart';
import 'package:fitter_fit/Entity/user_entity.dart';
// import 'package:fitter_fit/Services/clients_management_service.dart';
// import 'package:fitter_fit/Services/firebase_auth_service.dart';
import 'package:fitter_fit/Services/firestore_service.dart';
// import 'package:fitter_fit/Common_Widgets/invite_dialog.dart';
import 'package:fitter_fit/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientsView extends StatefulWidget {
  @override
  _ClientsViewState createState() => _ClientsViewState();
}

class _ClientsViewState extends State<ClientsView> {
  @override
  Widget build(BuildContext context) {
    final fireStoreService =
        Provider.of<FireStoreService>(context, listen: false);
    // final authService =
    //     Provider.of<FireBaseAuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerWidget(),
      floatingActionButton: inviteClientsFloatingActionButton(context),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: fireStoreService
              .getUserDocument(FirebaseAuth.instance.currentUser.uid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong!"));
            }
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            UserEntity trainerData = snapshot.data;
            if (trainerData.clients.isEmpty)
              //If the trainer has no clients i'm displaying a button to add some
              return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("No clients yet? Add some using the button below"),
                    ],
                  ),
                ),
              );
            //Clients list if the trainer has any
            String initialData = "Loading";
            return new ListView.builder(
              itemCount: trainerData.clients.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return StreamBuilder(
                    initialData: initialData,
                    stream: fireStoreService
                        .getUserDocument(trainerData.clients[index]),
                    builder: (context, snapshot) {
                      UserEntity clientData = snapshot.data;
                      return Container(
                        height: height(context) * 0.2,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed("SingleClientView");
                          },
                          child: Card(
                            elevation: 5.0,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    child: FlatButton(
                                      child:
                                          Icon(Icons.cancel, color: Colors.red),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              RemoveClientDialog(
                                            trainer: trainerData,
                                            client: clientData,
                                          ),
                                        );
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  clientData.name,
                                  // style: TextStyle(color: Colors.lightBlue),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Icon(Icons.arrow_forward),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            );
          },
        ),
      ),
    );
  }
}
