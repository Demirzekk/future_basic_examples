// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:future_basic_examples/page/chronometer/timer_history_list_page/model/timer_history_model.dart';
import 'package:future_basic_examples/page/chronometer/timer_history_list_page/timer_history.dart';
import 'package:future_basic_examples/page/chronometer_func_items/chronometer_items.dart';

import '../../../init/custom_widgets/custom_container.dart';
import '../../../init/custom_widgets/custom_floating_button.dart';

import 'chronometer_model_view.dart';

class ChronometerPage extends StatefulWidget {
  ChronometerPage({
    Key? key,
    required this.isPast,
    this.isSavePast,
    required this.pastMap,
  }) : super(key: key);

  @override
  State<ChronometerPage> createState() => _ChronometerPageState();

  late bool isPast;

  final List<Pastmap>? isSavePast;
  final Pastmap pastMap;
}

class _ChronometerPageState extends State<ChronometerPage>
    with SingleTickerProviderStateMixin {
 

  List<HistoryModel> historyList = [];

  bool paused = true;
  String date = "";

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
      const Duration(seconds: 1),
      (timer) {
        setState(() {});
        if (widget.isPast == true) {
          second = widget.pastMap.second ?? 5;
          minute = widget.pastMap.minute ?? 5;
          hour = widget.pastMap.hour ?? 5;
          widget.isPast = false;
        }
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
    initDate();
  }

// TODOS  - SORU : içinde set state olan metodları dışarıdan classtan nasıl alacağız. => başka bi yol var mı?
// ayrıca initialize edeceğimiz metodlarıda başka bir classtan alabilir miyiz?
  startTimer() {
    setState(() {
      paused = !paused;
    });
  }

  initDate() async {
    date = FunctionItems().dateFormatter(date);
  }

  init() async {
    historyList = await TimerViewModel().getTime(historyList);

    setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.isSavePast?.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  widget.isPast = false;

                  historyList.clear();
                  widget.isSavePast?.clear();

                  second = 0;
                  minute = 0;
                  hour = 0;
                });
              },
              icon: const Icon(Icons.delete))
        ],
        centerTitle: true,
        title: const Text("Kronometre"),
      ),
      floatingActionButton: CustomFloatingActionButton(
        buttonName: "Kaydet",
        timerFunction: () async {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const TimerHistoryPage()));

          historyList.add(HistoryModel(
              id: historyList.length + 1,
              day: date,
              pastmap: Pastmap(hour: hour, minute: minute, second: second)));

          TimerViewModel().setTime(historyList);

          setState(() {});
        },
      ),
      body: SingleChildScrollView(
        child: SizedBox(
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
                            ? widget.pastMap.hour ?? 45
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
                            ? widget.pastMap.minute ?? 45
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
                            ? widget.pastMap.second ?? 45
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
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white),
                label: Text(
                  paused ? "Başlat" : "Durdur",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
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
              ...widget.isSavePast?.map((e) {
                    return ListTile(
                      title: Text(
                          "Tur       ${e.hour.toString()} : ${e.minute.toString()} : ${e.second.toString()} "),
                    );
                  }).toList() ??
                  []
            ],
          ),
        ),
      ),
    );
  }
}
