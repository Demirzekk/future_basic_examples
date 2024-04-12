import 'dart:convert';
import 'dart:developer';

import 'package:future_basic_examples/page/chronometer/timer_history_list_page/model/timer_history_model.dart';

import '../../../init/cache_data/shared_data.dart';

class TimerViewModel {
  SharedPreferancesTimedata savedTimerData = SharedPreferancesTimedata();

  Future<List<HistoryModel>> setTime(HistoryModel historyModel) async {
    List<HistoryModel> historyModelList = [];
    List<String> total = historyModelList.map((e) => jsonEncode(e)).toList();

    await savedTimerData.getModelData(total);
    return historyModelList = await getTime();
  }

  Future<List<HistoryModel>> getTime() async {
    List<HistoryModel> historyModelList = [];
    List<String?>? decodeList = await savedTimerData.getUserListData();

    historyModelList = decodeList
            ?.map((e) => HistoryModel.fromMap(jsonDecode(e ?? "")))
            .toList() ??
        [];

    return historyModelList;
  }
}
