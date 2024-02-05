import 'package:flutter/material.dart';
import 'package:future_basic_examples/future_example/future_example3.dart';

import 'future_example/future_example2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Future Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FutureExample3(),
    );
  }
}
