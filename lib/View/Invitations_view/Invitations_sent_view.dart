import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitter_fit/Common_Widgets/cancel_invitation_dialog.dart';
// import 'package:fitter_fit/Entity/invitation_entity.dart';
import 'package:fitter_fit/Services/firestore_service.dart';
import 'package:fitter_fit/Services/invitations_service.dart';
import 'package:fitter_fit/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvitationsSentView extends StatefulWidget {
  @override
  _InvitationsSentViewState createState() => _InvitationsSentViewState();
}

class _InvitationsSentViewState extends State<InvitationsSentView> {
  @override
  Widget build(BuildContext context) {
    final invitationsService =
        Provider.of<InvitationsService>(context, listen: false);
    final fireStoreService =
        Provider.of<FireStoreService>(context, listen: false);
    return StreamBuilder(
      initialData: Container(child: Text("Loading...")),
      stream: invitationsService.getSentInvitations(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Center(child: Text("Something went wrong!"));
        }
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (snapshot.data.docs.length == 0)
          return Center(
            child: Text("No invitations sent."),
          );
        return new ListView.builder(
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              DocumentSnapshot _invitation = snapshot.data.docs[index];
              Map<String, dynamic> _invitationData = _invitation.data();
              return FutureBuilder(
                initialData: Card(child: Center(child: Text("Loading..."))),
                future: fireStoreService
                    .getUserDocumentFuture(_invitationData[clientId]),
                builder: (context, _userSnapshot) {
                  if (_userSnapshot.hasError) {
                    print(snapshot.error);
                    return Card(child: Text("Something went wrong!"));
                  }
                  if (_userSnapshot.connectionState == ConnectionState.waiting)
                    return Container(
                      height: height(context) * 0.15,
                      child: Card(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  return Container(
                    height: height(context) * 0.2,
                    child: Card(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: FlatButton(
                              child: Icon(
                                Icons.cancel_outlined,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => CancelInvitationDialog(
                                    invitationId: _invitation.id,
                                  ),
                                );
                              },
                            ),
                          ),
                          Text(_userSnapshot.data.name),
                        ],
                      ),
                    ),
                  );
                },
              );
            });
      },
    );
  }
}
