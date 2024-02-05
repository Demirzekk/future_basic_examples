import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FutureExample2 extends StatefulWidget {
  const FutureExample2({super.key});

  @override
  State<FutureExample2> createState() => _FutureExample2State();
}

class _FutureExample2State extends State<FutureExample2> {
  int count = 0;
  bool iconChange = false;
  late final Future<int?> myFuture;
  late final Future<List<String>?> names;

  Future<int?> countFuture() async {
    log("Başladı");
    for (int i = 0; i < 5; i++) {
      await Future.delayed(const Duration(seconds: 1));
      count++;
    }
    log("Bitti");
    if (count == 4) {
      return Future.error("4 sayısına rastlanıldı");
    }
    if (count == 5) {
      return null;
    }

    return count;
  }

  Future<List<String>?> getNames() async {
    log("Başladı");
    await Future.delayed(const Duration(seconds: 4));

    // return ["Ahmet", "Mehmet", "Ali"];

    return Future.error("İsim Bulunamadı");
  }

  @override
  void initState() {
    myFuture = countFuture();
    names = getSharedPrefList();
    super.initState();
  }

  Future<List<String>?> getSharedPrefList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    pref.setStringList("list", ["Ahmet", "Mehmet", "Ayşe", "Berk", "Dilber"]);
    final list = pref.getStringList("list2");
    if (list?.isEmpty == true) {
      return Future.error("İsim Bulunamadı");
    }
    // dynamic hhh = 2;
    // return hhh;
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Future Example 2"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder<List<String>?>(
            future: names,
            builder: (context, AsyncSnapshot<List<String>?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                    child: Text("Hata oluştu ${snapshot.error.toString()}"));
              }
              if (snapshot.hasData == false) {
                return const Center(
                  child: Text("Herhangi bir veri bulunamadı"),
                );
              }

              return Column(
                children: snapshot.data
                        ?.map((e) => ListTile(
                              title: Text(e.toString()),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    snapshot.data?.remove(e);
                                  });
                                },
                              ),
                            ))
                        .toList() ??
                    [],
              );
            },
          ),
          const SizedBox(
            height: 24,
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  iconChange = !iconChange;
                });
              },
              icon: Icon(
                iconChange ? Icons.pan_tool : Icons.abc,
                size: 30,
              ))
        ],
      ),
    );
  }
}
