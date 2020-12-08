import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitter_fit/Common_Widgets/accept_invitation_dialog.dart';
import 'package:fitter_fit/Common_Widgets/cancel_invitation_dialog.dart';
import 'package:fitter_fit/Entity/invitation_entity.dart';
import 'package:fitter_fit/Services/firestore_service.dart';
import 'package:fitter_fit/Services/invitations_service.dart';
import 'package:fitter_fit/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvitationsReceivedView extends StatefulWidget {
  @override
  _InvitationsReceivedViewState createState() =>
      _InvitationsReceivedViewState();
}

class _InvitationsReceivedViewState extends State<InvitationsReceivedView> {
  @override
  Widget build(BuildContext context) {
    final invitationsService =
        Provider.of<InvitationsService>(context, listen: false);
    final fireStoreService =
        Provider.of<FireStoreService>(context, listen: false);
    return StreamBuilder(
      initialData: Container(child: Text("Loading...")),
      stream: invitationsService.getReceivedInvitations(),
      builder: (context, invitationsSnapshot) {
        if (invitationsSnapshot.hasError) {
          return Center(child: Text("Something went wrong!"));
        }
        if (invitationsSnapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (invitationsSnapshot.data.docs.length == 0)
          return Center(child: Text("You have no invitations."));
        else
          return new ListView.builder(
              itemCount: invitationsSnapshot.data.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                DocumentSnapshot _invitation =
                    invitationsSnapshot.data.docs[index];
                InvitationEntity _invitationEntity = InvitationEntity()
                    .toInvitationEntity(invitationsSnapshot.data.docs[index].id,
                        _invitation.data());
                return FutureBuilder(
                  initialData: Card(child: Center(child: Text("Loading..."))),
                  future: fireStoreService
                      .getUserDocumentFuture(_invitationEntity.trainerId),
                  builder: (context, _trainerSnapshot) {
                    if (_trainerSnapshot.hasError) {
                      return Card(child: Text("Something went wrong!"));
                    }
                    if (_trainerSnapshot.connectionState ==
                        ConnectionState.waiting)
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_trainerSnapshot.data.name),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FlatButton.icon(
                                  icon: Icon(Icons.cancel),
                                  label: Text("Decline"),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          CancelInvitationDialog(
                                        invitationId: _invitation.id,
                                      ),
                                    );
                                  },
                                ),
                                FlatButton.icon(
                                  icon: Icon(Icons.check),
                                  label: Text("Accept"),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            AcceptInvitationDialog(
                                              invitationEntity:
                                                  _invitationEntity,
                                            ));
                                  },
                                ),
                              ],
                            )
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
