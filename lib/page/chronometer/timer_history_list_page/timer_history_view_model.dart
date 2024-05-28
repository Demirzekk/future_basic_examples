import 'model/timer_history_model.dart';

class TimerHistoryViewModel {
  List<Pastmap> thatDay(String histday, List<HistoryModel> histName,
      List<Pastmap> datetimeListName) {
    for (var i = 0; i < histName.length; i++) {
      if (histName[i].day?.contains(histday) == true) {
        datetimeListName.add(histName[i].pastmap ?? Pastmap());
      }
    }
    return datetimeListName;
  }
}
