import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  // TODOS Copywith metoduy kullanılabilir.

  @override
  void initState() {
    init();

    super.initState();
  }

  init() async {
    historyList = await TimerViewModel().getTime(historyList);

    log(historyList.length.toString());

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 500,
                width: 500,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: historyList.length,
                    itemBuilder: (context, index) {
                      var tek = historyList[index];

                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChronometerPage(
                                          isPast: true,
                                          pasthistoryList: HistoryModel(
                                              day: historyList[index].day,
                                              id: historyList[index].id,
                                              past: historyList[index].past))));
                            },
                            leading: Text(
                              tek.id.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(tek.day.toString(),
                                style: const TextStyle(color: Colors.white)),
                            title: Text(
                                "${tek.past?[index].totalhour} : ${tek.past?[index].totalminute} : ${tek.past?[index].totalsecond}",
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
