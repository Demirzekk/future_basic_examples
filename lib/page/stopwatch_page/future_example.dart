// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:future_basic_examples/init/cache_data/shared_data.dart';
import 'package:future_basic_examples/page/stopwatch_page/timer_history.dart';

import '../../init/custom_widgets/custom_container.dart';
import '../../init/custom_widgets/custom_floating_button.dart';

class FutureExamplePage extends StatefulWidget {
  const FutureExamplePage({super.key});

  @override
  State<FutureExamplePage> createState() => _FutureExamplePageState();
}

class _FutureExamplePageState extends State<FutureExamplePage>
    with SingleTickerProviderStateMixin {
  SharedPreferancesTimedata sharedtime = SharedPreferancesTimedata();

  init() async {
    setState(() {});
    await getTime();
  }

  setTime() async {
    List<String> res = saveTimeList.map((e) => jsonEncode(e)).toList();

    await sharedtime.getModelData(res);
  }

  

  getTime() async {
    List<String?>? res = await sharedtime.getUserListData();

    saveTimeList = res
            ?.map((e) => TotalTimeModel.fromJson(jsonDecode(e ?? "")))
            .toList() ??
        [];

    setState(() {});
  }

  TotalTimeModel? model;

  List<TotalTimeModel> saveTimeList = [];
  bool paused = false;
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

    controller = AnimationController(
      vsync: this,
      reverseDuration: const Duration(milliseconds: 200),
      duration: const Duration(milliseconds: 200),
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

    // timer start

    _timer = Timer.periodic(
      const Duration(milliseconds: 20),
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

  @override
  void dispose() {
    _timer?.cancel();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const ProfileDart(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Zamanlayıcı"),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomFloatingActionButton(
            buttonName: "sıfırla",
            timerFunction: () {
              minute = 0;
              second = 0;
              hour = 0;
              saveTimeList.clear();

              setTime();
              setState(() {});
            },
          ),
          const SizedBox(
            width: 200,
          ),
          CustomFloatingActionButton(
            buttonName: "tur",
            timerFunction: () {
              saveTimeList.add(TotalTimeModel(
                  totalsecond: second, totalminute: minute, totalhour: hour));
          
              setTime();
              setState(() {});
            },
          ),
        ],
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

class TotalTimeModel {
  int? totalsecond;
  int? totalminute;
  int? totalhour;
  List<TotalTimeModel>? totaltime;
  TotalTimeModel(
      {required this.totalsecond,
      this.totaltime,
      required this.totalminute,
      required this.totalhour});
  TotalTimeModel.fromJson(Map<String, dynamic> json) {
    totalsecond = json["totalsecond"];
    totalminute = json["totalminute"];
    totalhour = json["totalhour"];
    if (json["news"] != null) {
      totaltime = <TotalTimeModel>[];
      json["news"].forEach((dynamic v) {
        totaltime?.add(TotalTimeModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};

    json["totalsecond"] = totalsecond;
    json["totalminute"] = totalminute;
    json["totalhour"] = totalhour;
    if (totaltime != null) {
      json["news"] = totaltime?.map((v) => v.toJson()).toList();
    }

    return json;
  }
}




//async functions
// Birden fazla yapılan işlemlerde, bu işlemler arasında iş parcacığının tamamlanması diğer işlemlerden farklı
// ise burada async function kullanılır. Yada kısa süre içerisinde gerçekleşmeyen
// zamana ihtiyac duyan işlemlerde yine async functionlar kullanılır


