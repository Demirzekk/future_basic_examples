class TotalTimeModel {
  int? totalsecond;
  int? totalminute;
  int? totalhour;
  List<TotalTimeModel>? totaltime;
  TotalTimeModel(
      {required this.totalsecond,
      this.totaltime,
      required this.totalminute,
      required this.totalhour});
  TotalTimeModel.fromJson(Map<String, dynamic> json) {
    totalsecond = json["totalsecond"];
    totalminute = json["totalminute"];
    totalhour = json["totalhour"];
    if (json["news"] != null) {
      totaltime = <TotalTimeModel>[];
      json["news"].forEach((dynamic v) {
        totaltime?.add(TotalTimeModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};

    json["totalsecond"] = totalsecond;
    json["totalminute"] = totalminute;
    json["totalhour"] = totalhour;
    if (totaltime != null) {
      json["news"] = totaltime?.map((v) => v.toJson()).toList();
    }

    return json;
  }
}

