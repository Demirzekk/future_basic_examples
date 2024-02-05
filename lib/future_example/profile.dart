import 'package:flutter/material.dart';

class ProfileDart extends StatefulWidget {
  const ProfileDart({super.key});

  @override
  State<ProfileDart> createState() => _ProfileDartState();
}

class _ProfileDartState extends State<ProfileDart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 110, 88),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircleAvatar(backgroundColor: Colors.red, radius: 50),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Zamanlama takvimi",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.white),
              ),
              const SizedBox(
                height: 40,
              ),
              const SingleChoice(),
            ],
          ),
        ),
      ),
    );
  }
}

enum Calendar { second, minute, hour, day }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  Calendar calendarView = Calendar.day;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Calendar>(
      segments: const <ButtonSegment<Calendar>>[
        ButtonSegment<Calendar>(
            value: Calendar.second,
            label: Text('saniye'),
            icon: Icon(Icons.hourglass_empty)),
        ButtonSegment<Calendar>(
            value: Calendar.minute,
            label: Text('dakika'),
            icon: Icon(Icons.hourglass_top_outlined)),
        ButtonSegment<Calendar>(
            value: Calendar.hour,
            label: Text('saat'),
            icon: Icon(Icons.hourglass_bottom)),
        ButtonSegment<Calendar>(
            enabled: false,
            value: Calendar.day,
            label: Text('gün'),
            icon: Icon(Icons.view_day)),
      ],
      selected: <Calendar>{calendarView},
      onSelectionChanged: (Set<Calendar> newSelection) {
        setState(() {
          calendarView = newSelection.first;
        });
      },
    );
  }
}
