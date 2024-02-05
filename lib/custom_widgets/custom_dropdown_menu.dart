import 'package:flutter/material.dart';

class CustomDropDownMenu<String> extends StatelessWidget {
  const CustomDropDownMenu(
      {super.key,
      this.items,
      required this.dropDownVal,
      required this.onChanged});

  final List<String?>? items;

  final String? dropDownVal;
  final Function(String?) onChanged;
  @override
  Widget build(BuildContext context) {
    var dropDownVal = this.dropDownVal;
    return StatefulBuilder(builder: ((context, setState) {
      return DropdownButtonHideUnderline(
          child: DropdownButton(
              value: dropDownVal,
              items: items
                  ?.map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(e.toString()),
                      ))
                  .toList(),
              onChanged: (String? value) {
                onChanged(value);
                setState(() {
                  dropDownVal = value;
                });
              }));
    }));
  }
}
