import 'package:flutter/material.dart';

import 'package:future_basic_examples/page/chronometer/timer_history_list_page/timer_history.dart';



import 'init/constants/app_constant.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstans.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TimerHistoryPage(),
    );
  }
}
