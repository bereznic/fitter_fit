import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fitter_fit/Entity/user_entity.dart';
// import 'package:fitter_fit/Services/firestore_service.dart';
import 'package:fitter_fit/constants.dart';

class ClientsManagementService {
  CollectionReference usersRefference =
      FirebaseFirestore.instance.collection(usersCollection);

  // Stream<UserEntity> getClients(String _uid) {
  //   return usersRefference
  //       .doc(_uid)
  //       .snapshots(includeMetadataChanges: true)
  //       .map((DocumentSnapshot snapshot) =>
  //           FireStoreService().userFromSnapshot(snapshot, _uid));
  // }
}
