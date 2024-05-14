// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'total_timer_model.dart';

class HistoryModel {
  int? id;
  String? day;
  List<TimeModel>? past;

  HistoryModel({this.id, this.day, this.past});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    if (json['past'] != null) {
      past = <TimeModel>[];
      json['past'].forEach((v) {
        past!.add(TimeModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['day'] = day;
    if (past != null) {
      data['past'] = past!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() => 'HistoryModel(id: $id, day: $day, past: $past)';

  HistoryModel copyWith({
    int? id,
    String? day,
    List<TimeModel>? past,
  }) {
    return HistoryModel(
      id: id ?? this.id,
      day: day ?? this.day,
      past: past ?? this.past,
    );
  }
}
