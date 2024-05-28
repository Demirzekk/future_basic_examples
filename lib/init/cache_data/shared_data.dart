import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferancesTimedata {
  static const stopWatchData = "savedTimer";
  static const stopWatch = "save";
  Future<SharedPreferences> initShared() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  Future<bool> setModelData(List<String> value) async {
    final prefs = await initShared();
    return prefs.setStringList(stopWatchData, value);
  }

  Future<List<String?>?> getUserListData() async {
    final pref = await initShared();
    return pref.getStringList(stopWatchData);
  }

  Future<bool> setModelTimeList(List<String> value) async {
    final prefs = await initShared();
    return prefs.setStringList(stopWatch, value);
  }

   Future<List<String?>?> getModelTimeList() async {
    final pref = await initShared();
    return pref.getStringList(stopWatch);
  }


}
