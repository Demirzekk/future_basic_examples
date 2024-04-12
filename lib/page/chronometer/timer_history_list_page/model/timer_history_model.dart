import 'package:future_basic_examples/page/chronometer/timer_history_list_page/model/total_timer_model.dart';

class HistoryModel {
  int id;
  String day;
  List<TotalTimeModel>? totalTimeModel;
  HistoryModel({
    required this.id,
    required this.day,
    required this.totalTimeModel,
  });

  HistoryModel copyWith({
    int? id,
    String? day,
    List<TotalTimeModel>? totalTimeModel,
  }) {
    return HistoryModel(
      id: id ?? this.id,
      day: day ?? this.day,
      totalTimeModel: totalTimeModel ?? this.totalTimeModel,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'day': day});
    result.addAll({'subTime': totalTimeModel});

    return result;
  }

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      id: map['id']?.toInt() ?? 0,
      day: map['day'] ?? '',
      totalTimeModel: List<TotalTimeModel>.from(map['subTime']),
    );
  }

  @override
  String toString() =>
      'HistoryModel(id: $id, day: $day, subTime: $totalTimeModel)';
}

// class SubTimeModel {
//   int hour;
//   int munite;
//   int second;
//   int millisecond;
//   SubTimeModel({
//     required this.hour,
//     required this.munite,
//     required this.second,
//     required this.millisecond,
//   });

//   SubTimeModel copyWith({
//     int? hour,
//     int? munite,
//     int? second,
//     int? millisecond,
//   }) {
//     return SubTimeModel(
//       hour: hour ?? this.hour,
//       munite: munite ?? this.munite,
//       second: second ?? this.second,
//       millisecond: millisecond ?? this.millisecond,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     final result = <String, dynamic>{};

//     result.addAll({'hour': hour});
//     result.addAll({'munite': munite});
//     result.addAll({'second': second});
//     result.addAll({'millisecond': millisecond});

//     return result;
//   }

//   factory SubTimeModel.fromMap(Map<String, dynamic> map) {
//     return SubTimeModel(
//       hour: map['hour']?.toInt() ?? 0,
//       munite: map['munite']?.toInt() ?? 0,
//       second: map['second']?.toInt() ?? 0,
//       millisecond: map['millisecond']?.toInt() ?? 0,
//     );
//   }

//   @override
//   String toString() {
//     return 'SubTimeModel(hour: $hour, munite: $munite, second: $second, millisecond: $millisecond)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is SubTimeModel &&
//         other.hour == hour &&
//         other.munite == munite &&
//         other.second == second &&
//         other.millisecond == millisecond;
//   }

//   @override
//   int get hashCode {
//     return hour.hashCode ^
//         munite.hashCode ^
//         second.hashCode ^
//         millisecond.hashCode;
//   }
// }
