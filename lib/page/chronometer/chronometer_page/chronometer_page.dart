import 'dart:async';

import 'package:flutter/material.dart';

import 'package:future_basic_examples/page/chronometer/timer_history_list_page/model/timer_history_model.dart';
import 'package:future_basic_examples/page/chronometer/timer_history_list_page/timer_history.dart';

import '../../../init/custom_widgets/custom_container.dart';
import '../../../init/custom_widgets/custom_floating_button.dart';

import '../timer_history_list_page/model/total_timer_model.dart';
import 'chronometer_model_view.dart';

class ChronometerPage extends StatefulWidget {
  const ChronometerPage(
      {super.key, required this.pasthistoryList, required this.isPast});

  @override
  State<ChronometerPage> createState() => _ChronometerPageState();
  final HistoryModel pasthistoryList;
  final bool isPast;
}

class _ChronometerPageState extends State<ChronometerPage>
    with SingleTickerProviderStateMixin {
  final DateTime now = DateTime.now();

  TimerHistoryPage? historyPage;

  List<TimeModel> timeList = [];
  List<HistoryModel> historyList = [];

  asd() {}

  bool paused = true;

  Timer? _timer;
  int second = 0;
  int minute = 0;
  int hour = 0;
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      reverseDuration: const Duration(milliseconds: 200),
      duration: const Duration(milliseconds: 200),
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

    _timer = Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) {
        if (paused == false) {
          setState(() {
            second++;
          });
        }
        if (second == 59) {
          second = 0;
          minute++;
        }
        if (minute == 59) {
          minute = 0;
          hour++;
        }
      },
    );
    init();
  }

  startTimer() {
    setState(() {
      paused = !paused;
    });
  }

  init() async {
    historyList = await TimerViewModel().getTime(historyList);

    setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  String dateFormatter() {
    var month = DateTime.now().month;
    var day = DateTime.now().day;
    var year = DateTime.now().year;
    return "$day/$month/$year";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Kronometre"),
      ),
      floatingActionButton: CustomFloatingActionButton(
        buttonName: "Kaydet",
        timerFunction: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const TimerHistoryPage()));

          timeList.add(TimeModel(
              totalsecond: second, totalminute: minute, totalhour: hour));
          historyList.add(HistoryModel(
              id: timeList.length, day: dateFormatter(), past: timeList));

          TimerViewModel().setTime(historyList);

          setState(() {});
        },
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomContainerTime(
                      time: widget.isPast == true
                          ? widget.pasthistoryList.past?.first.totalhour ?? 10
                          : hour),
                  Text(
                    ":",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 30),
                  ),
                  CustomContainerTime(
                      time: widget.isPast == true
                          ? widget.pasthistoryList.past?.first.totalminute ?? 10
                          : minute),
                  Text(
                    ":",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 30),
                  ),
                  CustomContainerTime(
                      time: widget.isPast == true
                          ? widget.pasthistoryList.past?.first.totalsecond ?? 10
                          : second)
                ],
              ),
            ),
            SliderTheme(
              data: const SliderThemeData(
                trackHeight: 10,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
              ),
              child: Slider(
                activeColor: Colors.teal.shade700,
                inactiveColor: Colors.teal.shade300,
                value: second.toDouble(),
                divisions: 200,
                min: 0,
                max: 59,
                onChanged: (double val) async {
                  setState(() {
                    second = val.toInt();
                  });
                },
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton.icon(
              label: Text(paused ? "Başlat" : "Durdur"),
              onPressed: () {
                paused ? controller.forward() : controller.reverse();
                startTimer();
              },
              icon: AnimatedIcon(
                  icon: AnimatedIcons.play_pause, progress: animation),
            ),
            const SizedBox(
              width: 50,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    TextButton(
                        onPressed: () {
                          timeList.clear();
                          historyList.clear();
                          setState(() {});
                        },
                        child: const Text("sil"))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
