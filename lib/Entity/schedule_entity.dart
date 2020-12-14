class ScheduleEntity {
  String scheduleId;
  String name;
  String owner;
  List<String> guests;
  String date;
  String description;

  ScheduleEntity(
      {this.scheduleId,
      this.name,
      this.owner,
      this.guests,
      this.date,
      this.description});

  String get getScheduleId => scheduleId;

  set setScheduleId(String scheduleId) => this.scheduleId = scheduleId;

  String get getName => name;

  set setName(String name) => this.name = name;

  String get getOwner => owner;

  set setOwner(String owner) => this.owner = owner;

  List<String> get getGuests => guests;

  set setGuests(List<String> guestsIds) => this.guests = guestsIds;

  String get getDate => date;

  set setDate(String date) => this.date = date;

  String get getDescription => description;

  set setDescription(String description) => this.description = description;

  ScheduleEntity toScheduleEntity(
      String _scheduleId, Map<String, dynamic> _data) {
    return ScheduleEntity(
      scheduleId: _scheduleId,
      name: _data['name'],
      guests: List.from(_data['guests']),
      date: _data['date'],
    );
  }

  Map<String, dynamic> scheduleToMap(ScheduleEntity scheduleEntity) {
    return ({
      'name': scheduleEntity.name,
      'date': scheduleEntity.date,
      'owner': scheduleEntity.owner,
      'guests': scheduleEntity.guests
    });
  }
}
