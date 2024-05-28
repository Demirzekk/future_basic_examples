class FunctionItems {
  String dateFormatter(String date) {
    final DateTime now = DateTime.now();

    var month = now.month;
    var day = now.day;
    var year = now.year;
    date = "$day/$month/$year";
    return date;
  }
}
