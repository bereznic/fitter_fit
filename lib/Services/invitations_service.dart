import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitter_fit/Entity/invitation_entity.dart';
import 'package:fitter_fit/Entity/user_entity.dart';
import 'package:fitter_fit/Services/firebase_auth_service.dart';
import 'package:fitter_fit/Services/firestore_service.dart';
import 'package:fitter_fit/constants.dart';

class InvitationsService {
  CollectionReference usersRefference =
      FirebaseFirestore.instance.collection(usersCollection);
  CollectionReference invitationsRefference =
      FirebaseFirestore.instance.collection(invitationsCollection);
  FireStoreService fireStoreService = new FireStoreService();
  FireBaseAuthService fireBaseAuthService = new FireBaseAuthService();

  Future<String> sendInvitation(String _email) async {
    UserEntity userEntity = new UserEntity();

    return getClientIdByEmail(_email).then((_clientSnapshot) {
      if (_clientSnapshot.docs.isNotEmpty) {
        UserEntity _clientData = userEntity.toUserEntity(
            _clientSnapshot.docs[0].id, _clientSnapshot.docs[0].data());
        return fireBaseAuthService.getCurrentUser().then((_trainerData) {
          bool containsClient =
              checkIfTrainerContainsClient(_trainerData, _clientData);
          if (containsClient == false) {
            return checkIfInvitationExists(_clientData, _trainerData)
                .then((_invitationSnapshot) {
              if (_invitationSnapshot.docs.isEmpty) {
                return invitationsRefference.add({
                  clientId: _clientData.uid,
                  trainerId: _trainerData.uid
                }).then((value) => success);
              } else
                return invitationSentAlready;
            });
          } else
            return alreadyClient;
        });
      } else
        return userNotFound;
    });
  }

  Future<QuerySnapshot> getClientIdByEmail(String _email) async {
    return fireStoreService.usersRefference
        .where(
          email,
          isEqualTo: _email,
        )
        .limit(1)
        .get();
  }

  Future<QuerySnapshot> checkIfInvitationExists(
      UserEntity _client, UserEntity _trainer) async {
    return invitationsRefference
        .where(
          clientId,
          isEqualTo: _client.uid,
        )
        .where(trainerId, isEqualTo: _trainer.uid)
        .limit(1)
        .get();
  }

  Stream<QuerySnapshot> getSentInvitations() {
    String _currentUserUid = FirebaseAuth.instance.currentUser.uid;

    return invitationsRefference
        .where(trainerId, isEqualTo: _currentUserUid)
        .snapshots();
  }

  Stream<QuerySnapshot> getReceivedInvitations() {
    String _currentUserUid = FirebaseAuth.instance.currentUser.uid;

    return invitationsRefference
        .where(clientId, isEqualTo: _currentUserUid)
        .snapshots();
  }

  bool checkIfTrainerContainsClient(UserEntity _trainer, UserEntity _client) {
    return _trainer.clients.contains(_client.uid);
  }

  Future<String> acceptInvitation(InvitationEntity _invitationEntity) {
    return usersRefference.doc(_invitationEntity.trainerId).update({
      clients: FieldValue.arrayUnion([_invitationEntity.clientId])
    }).then((value) {
      return deleteInvitation(_invitationEntity.invitationId)
          .then((value) => "success")
          .catchError((error) => "fail");
    }).catchError((error) => 'fail');
  }

  Future<String> deleteInvitation(String _invitationUid) {
    return invitationsRefference
        .doc(_invitationUid)
        .delete()
        .then((value) => "success")
        .catchError((error) => "fail");
  }
}
