import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:fitter_fit/Entity/user_entity.dart';
import 'package:fitter_fit/constants.dart';

class FireStoreService {
  CollectionReference usersRefference =
      FirebaseFirestore.instance.collection(usersCollection);
  UserEntity userEntity = new UserEntity();

  Future<bool> storeUser(UserEntity userEntity) {
    return usersRefference.doc(userEntity.uid).set({
      email: userEntity.email,
      name: userEntity.name,
      userType: userEntity.userType
    }).then((value) {
      print("Stored successfully!");
      return true;
    }).catchError((error) {
      print("eror $error");
      return false;
    });
  }

  //UPGRADE DE LA CLIENT LA TRAINER
  Future<void> makeTrainer(String userId) async {
    await usersRefference
        .doc(userId)
        .update({userType: trainer, 'clients': FieldValue.arrayUnion([])});
  }

  //ADUC USER DOCUMENT-UL CU ID-UL DAT
  Stream<UserEntity> getUserDocument(String _uid) {
    // return await usersRefference.doc(_uid).get();
    return usersRefference
        .doc(_uid)
        .snapshots(includeMetadataChanges: true)
        .map((snapshot) => userEntity.toUserEntity(_uid, snapshot.data()));
  }

  Future<UserEntity> getUserDocumentFuture(String _uid) {
    return usersRefference
        .doc(_uid)
        .get()
        .then((_snapshot) => userEntity.toUserEntity(_uid, _snapshot.data()));
  }

  Future<void> removeClient(UserEntity _trainer, String _clientId) async {
    bool result = _trainer.clients.remove(_clientId);

    if (result == true) {
      return usersRefference
          .doc(_trainer.uid)
          .update({clients: _trainer.clients});
    }
  }
}
