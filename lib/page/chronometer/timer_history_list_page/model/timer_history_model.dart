class HistoryModel {
  int? id;
  String? day;

  Pastmap? pastmap;

  HistoryModel({this.id, this.day, this.pastmap});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];

    pastmap =
        json['pastmap'] != null ? Pastmap.fromJson(json['pastmap']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['day'] = day;

    if (pastmap != null) {
      data['pastmap'] = pastmap!.toJson();
    }
    return data;
  }
}

class Pastmap {
  int? second;
  int? minute;
  int? hour;

  Pastmap({this.second, this.minute, this.hour});

  Pastmap.fromJson(Map<String, dynamic> json) {
    second = json['second'];
    minute = json['minute'];
    hour = json['hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['second'] = second;
    data['minute'] = minute;
    data['hour'] = hour;
    return data;
  }
}
