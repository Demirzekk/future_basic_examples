import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferancesTimedata {
  static const stopWatchData = "savedTimer";
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
}
