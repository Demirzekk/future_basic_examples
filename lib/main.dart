import 'package:flutter/material.dart';
import 'package:future_basic_examples/page/stopwatch_page/future_example.dart';

import 'package:future_basic_examples/page/user_login_page.dart/future_example4.dart';

import 'init/constants/app_constant.dart';
import 'page/user_fetch_data_example_page.dart/future_example3.dart';
import 'page/user_loading_page/future_example2.dart';

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
      home: const FutureExamplePage(),
    );
  }
}
