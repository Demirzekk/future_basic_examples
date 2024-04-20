
class TimeModel {
  int? totalsecond;
  int? totalminute;
  int? totalhour;
 
  TimeModel(
      {required this.totalsecond,
   
      required this.totalminute,
      required this.totalhour});
  TimeModel.fromJson(Map<String, dynamic> json) {
    totalsecond = json["totalsecond"];
    totalminute = json["totalminute"];
    totalhour = json["totalhour"];
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};

    json["totalsecond"] = totalsecond;
    json["totalminute"] = totalminute;
    json["totalhour"] = totalhour;
   
    return json;
  }

  @override
  String toString() => 'TimeModel(totalsecond: $totalsecond, totalminute: $totalminute, totalhour: $totalhour)';
}

