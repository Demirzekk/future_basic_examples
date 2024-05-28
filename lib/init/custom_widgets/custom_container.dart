import 'package:flutter/material.dart';

class CustomContainerTime extends StatelessWidget {
  const CustomContainerTime({super.key, required this.time});
  final int time;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            color: Colors.teal.shade700,
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            time.toString(),
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}