class InvitationEntity {
  String invitationId;
  String date;
  String clientId;
  String trainerId;

  InvitationEntity(
      {this.invitationId, this.date, this.clientId, this.trainerId});

  String get getInvitationId => invitationId;

  set setInvitationId(String invitationId) => this.invitationId = invitationId;

  String get getDate => date;

  set setDate(String date) => this.date = date;

  String get getClientId => clientId;

  set setClientId(String clientId) => this.clientId = clientId;

  String get getTrainerId => trainerId;

  set setTrainerId(String trainerId) => this.trainerId = trainerId;

  InvitationEntity toInvitationEntity(
      String _invitationUid, Map<String, dynamic> _invitationData) {
    return InvitationEntity(
        invitationId: _invitationUid,
        clientId: _invitationData['clientId'],
        trainerId: _invitationData['trainerId']);
  }
}
