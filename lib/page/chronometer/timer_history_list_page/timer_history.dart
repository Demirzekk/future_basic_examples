import 'package:flutter/material.dart';
import 'package:future_basic_examples/page/chronometer/timer_history_list_page/model/timer_history_model.dart';
import 'package:lottie/lottie.dart';

import '../chronometer_page/chronometer_model_view.dart';
import '../chronometer_page/chronometer_page.dart';

class TimerHistoryPage extends StatefulWidget {
  const TimerHistoryPage({super.key});

  @override
  State<TimerHistoryPage> createState() => _TimerHistoryPageState();
}

class _TimerHistoryPageState extends State<TimerHistoryPage> {
  List<HistoryModel>? historyModel;
  final TimerViewModel _timerViewModel = TimerViewModel();
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    historyModel = await _timerViewModel.getTime();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ChronometerPage()));
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color.fromARGB(255, 9, 110, 88),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: LottieBuilder.asset(
              "assets/lottie/watch_lottie.json",
              repeat: false,
            ),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 9, 110, 88),
            expandedHeight: 90,
            pinned: true,
            floating: true,
            flexibleSpace: const FlexibleSpaceBar(
              title: Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                child: Text(
                  "Tur Geçmişi",
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: historyModel?.length ?? 0,
                  (BuildContext context, int index) {
            final item = historyModel?[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChronometerPage(
                              historyModel: item,
                            )));
              },
              leading: Text(
                item?.id.toString() ?? "",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.white),
              ),
              title: Text(
                item?.day ?? "null",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.white),
              ),
            );
          }))
        ],
      ),
    );
  }
}
