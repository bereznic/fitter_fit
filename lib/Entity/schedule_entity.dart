class ScheduleEntity {
  String name;
  String scheduleId;
  String date;
  String clientId;

  ScheduleEntity({this.scheduleId, this.name, this.date, this.clientId});

  String get getScheduleId => scheduleId;

  set setScheduleId(String scheduleId) => this.scheduleId = scheduleId;

  String get getClientId => clientId;

  set setClientId(String clientId) => this.clientId = clientId;

  String get getName => name;

  set setName(String name) => this.name = name;

  ScheduleEntity toScheduleEntity(
      String _scheduleId, Map<String, dynamic> _data) {
    return ScheduleEntity(
      scheduleId: _scheduleId,
      date: _data['date'],
      name: _data['name'],
      clientId: _data['clientId'],
    );
  }
}
