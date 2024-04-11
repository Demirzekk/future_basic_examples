import 'dart:convert';

import '../../init/cache_data/shared_data.dart';
import 'future_example.dart';

class TimerViewModel {
  List<TotalTimeModel> saveTimeList = [];
  SharedPreferancesTimedata timedata = SharedPreferancesTimedata();

  setTime() async {
    List<String> total = saveTimeList.map((e) => jsonEncode(e)).toList();

    await timedata.getModelData(total);
  }

  getTime() async {
    List<String?>? decodeList = await timedata.getUserListData();

    saveTimeList = decodeList
            ?.map((e) => TotalTimeModel.fromJson(jsonDecode(e ?? "")))
            .toList() ??
        [];
  }
}

// TODO view model özelliği kullanılacak: