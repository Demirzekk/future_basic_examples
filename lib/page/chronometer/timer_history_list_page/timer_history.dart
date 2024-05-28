import 'package:flutter/material.dart';

import 'package:future_basic_examples/page/chronometer/timer_history_list_page/model/timer_history_model.dart';
import 'package:future_basic_examples/page/chronometer/timer_history_list_page/timer_history_view_model.dart';

import '../chronometer_page/chronometer_model_view.dart';
import '../chronometer_page/chronometer_page.dart';

class TimerHistoryPage extends StatefulWidget {
  const TimerHistoryPage({super.key});

  @override
  State<TimerHistoryPage> createState() => _TimerHistoryPageState();
}

class _TimerHistoryPageState extends State<TimerHistoryPage> {
  List<HistoryModel> historyList = [];
  List<Pastmap> thatDayList = [];

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
        floatingActionButton: SizedBox(
          height: 50,
          width: 150,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {});
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChronometerPage(
                            pastMap: Pastmap(hour: 0, second: 0, minute: 0),
                            isPast: false,
                          )));
            },
            child: const Text("zaman ekle"),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 9, 110, 88),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 750,
                width: 500,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: historyList.length,
                    itemBuilder: (context, index) {
                      var histListIndex = historyList[index];

                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              TimerHistoryViewModel().thatDay(
                                  histListIndex.day ?? "",
                                  historyList,
                                  thatDayList);

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChronometerPage(
                                            pastMap: Pastmap(
                                                hour: historyList[index]
                                                    .pastmap
                                                    ?.hour,
                                                minute: historyList[index]
                                                    .pastmap
                                                    ?.minute,
                                                second: historyList[index]
                                                    .pastmap
                                                    ?.second),
                                            isSavePast: thatDayList,
                                            isPast: true,
                                          )));
                            },
                            leading: Text(
                              histListIndex.id.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(histListIndex.day.toString(),
                                style: const TextStyle(color: Colors.white)),
                            title: Text(
                                "${histListIndex.pastmap?.hour} : ${histListIndex.pastmap?.minute} : ${histListIndex.pastmap?.second}",
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
                      );
                    }),
              )
            ],
          ),
        ));
  }
}
