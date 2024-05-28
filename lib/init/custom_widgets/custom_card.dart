import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.data});
  final String? data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 100,
      child: Card(
        shadowColor: Colors.teal,
        child: Center(child: Text(data ?? "")),
      ),
    );
  }
}
