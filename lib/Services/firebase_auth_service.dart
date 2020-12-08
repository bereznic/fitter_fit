// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitter_fit/Entity/user_entity.dart';
import 'package:fitter_fit/Services/firestore_service.dart';
import 'package:fitter_fit/constants.dart';

// @immutable
// class User {
//   const User({@required this.uid});
//   final String uid;
// }

class FireBaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FireStoreService();

  CollectionReference usersRefference =
      FirebaseFirestore.instance.collection(usersCollection);

  Stream<User> get onAuthStateChanged => _firebaseAuth.authStateChanges();

  Future<bool> register(UserEntity user) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return false;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return false;
      }
    } catch (e) {
      print(e);
    }
    user.uid = _firebaseAuth.currentUser.uid;
    return await _fireStore.storeUser(user);
  }

  Future<bool> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return false;
      } else if (e.code == 'wrong-password') {
        return false;
      }
    }
    return true;
  }

  //LUAM ID-UL USER-ULUI LOGAT, DUPA CARE LUAM DOCUMENTUL ACESTUIA SI-l RETURNAM CA USER ENTITY
  Future<UserEntity> getCurrentUser() async {
    UserEntity _currentUser = new UserEntity();
    String _currentUserUid = _firebaseAuth.currentUser.uid;
    return usersRefference.doc(_currentUserUid).get().then((documentSnapshot) {
      if (documentSnapshot.exists)
        return _currentUser.toUserEntity(
            _currentUserUid, documentSnapshot.data());
      else
        return new UserEntity();
    });
  }

  Future<void> logout() {
    _firebaseAuth.signOut();
    return null;
  }
}
