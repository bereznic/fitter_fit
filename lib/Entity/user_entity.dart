import 'package:fitter_fit/constants.dart';

class UserEntity {
  String uid;
  String email;
  String password;
  String name;
  String userType;
  List<String> clients;

  UserEntity(
      {this.uid,
      this.email,
      this.password,
      this.name,
      this.userType,
      this.clients});

  String get getUid => uid;

  set setUid(String uid) => this.uid = uid;

  String get getEmail => email;

  set setEmail(String email) => this.email = email;

  String get getPassword => password;

  set setPassword(String password) => this.password = password;

  String get getUserType => userType;

  set setUserType(String newUserType) => this.userType = newUserType;

  List<String> get getClients => clients;

  // set setClient(String cid) => this.clients.add(cid);

  UserEntity toUserEntity(String _uid, Map<String, dynamic> _data) {
    if (_data['userType'] == client)
      return UserEntity(
          uid: _uid,
          email: _data['email'],
          name: _data['name'],
          userType: _data['userType']);
    return UserEntity(
        uid: _uid,
        email: _data['email'],
        name: _data['name'],
        userType: _data['userType'],
        clients: List.from(_data['clients']));
  }
}
