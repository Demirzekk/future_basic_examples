import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton(
      {super.key, required this.buttonName, this.timerFunction});
  final void Function()? timerFunction;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: timerFunction, child: Text(buttonName));
  }
}
