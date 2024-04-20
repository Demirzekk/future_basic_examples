import 'package:flutter/material.dart';
import 'package:future_basic_examples/page/chronometer/timer_history_list_page/model/timer_history_model.dart';

import '../chronometer_page/chronometer_model_view.dart';
import '../chronometer_page/chronometer_page.dart';

class TimerHistoryPage extends StatefulWidget {
  const TimerHistoryPage({super.key});

  @override
  State<TimerHistoryPage> createState() => _TimerHistoryPageState();
}

class _TimerHistoryPageState extends State<TimerHistoryPage> {
  List<HistoryModel> historyList = [];

  @override
  void initState() {
    init();

    super.initState();
  }

  init() async {
    historyList = await TimerViewModel().getTime(historyList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 9, 110, 88),
          title: const Text(
            "Zamanlama Geçmişi",
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChronometerPage(
                          isPast: false,
                          pasthistoryList: HistoryModel(),
                        )));
          },
          child: const Icon(Icons.add),
        ),
        backgroundColor: const Color.fromARGB(255, 9, 110, 88),
        body: Column(
          children: [
            ...historyList.map((e) => Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChronometerPage(
                                      isPast: true,
                                      pasthistoryList: HistoryModel(),
                                    )));
                      },
                      leading: Text(
                        e.id.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(e.day.toString(),
                          style: const TextStyle(color: Colors.white)),
                      title: Text(
                          "${e.past?.first.totalhour} : ${e.past?.first.totalminute} : ${e.past?.first.totalsecond}",
                          style: const TextStyle(color: Colors.white)),
                      trailing: const Icon(
                        Icons.navigate_next_outlined,
                        color: Colors.white,
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                    )
                  ],
                ))
          ],
        ));
  }
}
