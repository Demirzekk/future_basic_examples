import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferancesTimedata{
   Future<SharedPreferences> initShared() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  

}