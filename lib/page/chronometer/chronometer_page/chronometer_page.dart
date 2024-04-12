// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:future_basic_examples/init/cache_data/shared_data.dart';

import '../../../init/custom_widgets/custom_container.dart';
import '../../../init/custom_widgets/custom_floating_button.dart';
import '../timer_history_list_page/model/timer_history_model.dart';
import '../timer_history_list_page/model/total_timer_model.dart';
import 'chronometer_model_view.dart';

class ChronometerPage extends StatefulWidget {
  const ChronometerPage({super.key, this.historyModel});
  final HistoryModel? historyModel;
  @override
  State<ChronometerPage> createState() => _ChronometerPageState();
}

class _ChronometerPageState extends State<ChronometerPage>
    with SingleTickerProviderStateMixin {
  TotalTimeModel? model;

  List<TotalTimeModel> saveTimeList = [];
  bool paused = true;
  bool tek = false;

  Timer? _timer;
  int second = 0;
  int minute = 0;
  int hour = 0;
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    saveTimeList = widget.historyModel?.totalTimeModel ?? [];
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
  }

  startTimer() {
    setState(() {
      paused = !paused;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
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
          saveTimeList.add(TotalTimeModel(
              totalsecond: second, totalminute: minute, totalhour: hour));
          final historyModel = widget.historyModel != null
              ? widget.historyModel?.copyWith(
                  id: widget.historyModel?.id,
                  day: widget.historyModel?.day,
                  totalTimeModel: saveTimeList)
              : HistoryModel(
                  id: 1,
                  day: DateTime.now().toString(),
                  totalTimeModel: saveTimeList);
          if (historyModel != null) {
            await TimerViewModel().setTime(historyModel);
          }
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
                  CustomContainerTime(time: hour),
                  Text(
                    ":",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 30),
                  ),
                  CustomContainerTime(time: minute),
                  Text(
                    ":",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 30),
                  ),
                  CustomContainerTime(time: second)
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
                    ...List.generate(saveTimeList.length, (index) {
                      return Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 100),
                            child: ListTile(
                              leading: Text((index + 1).toString()),
                              title: Text(
                                  " ${saveTimeList[index].totalhour.toString()}  :   ${saveTimeList[index].totalminute.toString()} , ${saveTimeList[index].totalsecond.toString()}"),
                            ),
                          ),
                          Divider(
                            color: Colors.teal.shade900,
                            height: 1,
                            endIndent: 50,
                            indent: 50,
                            thickness: 1,
                          ),
                        ],
                      );
                    }).toList(),
                    const SizedBox(
                      height: 120,
                    ),
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
