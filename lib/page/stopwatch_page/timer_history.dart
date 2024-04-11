import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../init/cache_data/shared_data.dart';
import 'future_example.dart';

class ProfileDart extends StatefulWidget {
  const ProfileDart({super.key});

  @override
  State<ProfileDart> createState() => _ProfileDartState();
}

class _ProfileDartState extends State<ProfileDart> {
  @override
  void initState() {
    getTime();
    super.initState();
  }

  SharedPreferancesTimedata timedata = SharedPreferancesTimedata();
  TotalTimeModel? model;
  List<TotalTimeModel> filterTime = [];

  getTime() async {
    List<String?>? result = await timedata.getUserListData();

    filterTime = result
            ?.map((e) => TotalTimeModel.fromJson(jsonDecode(e ?? "")))
            .toList() ??
        [];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            flexibleSpace: FlexibleSpaceBar(
              title: const Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                child: Text(
                  "Tur Geçmişi",
                ),
              ),
            ),
          ),
          SliverList(
              delegate:
                  SliverChildBuilderDelegate(childCount: filterTime.length,
                      (BuildContext context, int index) {
            return ListTile(
              leading: Text(
                (index + 1).toString(),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.white),
              ),
              title: Text(
                "${filterTime[index].totalhour} : ${filterTime[index].totalminute} : ${filterTime[index].totalsecond}  ",
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
