import 'dart:convert';

import 'package:future_basic_examples/page/chronometer/timer_history_list_page/model/timer_history_model.dart';


import '../../../init/cache_data/shared_data.dart';

class TimerViewModel {
  SharedPreferancesTimedata savedTimerData = SharedPreferancesTimedata();

  Future<bool> setTime(List<HistoryModel> timeModelListName) async {
    List<String> res = timeModelListName.map((e) => jsonEncode(e)).toList();
    return savedTimerData.setModelData(res);
  }

  Future<List<HistoryModel>> getTime(
      List<HistoryModel> timeModelListName) async {
    List<String?>? res = await savedTimerData.getUserListData();

    var timeModelListName =
        res?.map((e) => HistoryModel.fromJson(jsonDecode(e ?? ""))).toList() ??
            [];

    return timeModelListName;
  }
}


