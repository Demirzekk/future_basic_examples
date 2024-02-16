// ignore_for_file: unused_import

import 'dart:developer';

import 'package:flutter/material.dart';

import '../init/constants/url_constants.dart';
import '../init/enum/app_enum.dart';
import '../init/extension/extensions.dart';
import '../init/model/user_model.dart';

class FutureExample3 extends StatefulWidget {
  const FutureExample3({super.key});

  @override
  State<FutureExample3> createState() => _FutureExample3State();
}

class _FutureExample3State extends State<FutureExample3> {
  UserModel userModel = UserModel();

  Future init() async {
    setState(() {
      userModel = userModel.copyWith(
          name: "Ahmet",
          surname: "Yıldız",
          status: StatusEnum.waiting,
          backgroundImage: UrlConstants().backgroundImageUrl);
    });

    await Future.delayed(const Duration(seconds: 2));

    if (userModel.istimeOut.enableTimeout() == StatusEnum.timeOut) {
      userModel =
          userModel.copyWith(status: userModel.istimeOut.enableTimeout());
      return await Future.error(userModel);
    }
    setState(() {
      userModel = userModel.copyWith(
          status: StatusEnum.success, name: "Mehmet", city: "Kırklareli");
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Future Example 3")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: size.width,
            padding: const EdgeInsets.all(32),
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "User Information",
                    style: theme.titleLarge?.copyWith(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 150,
                    width: double.maxFinite,
                    child: Stack(
                      children: [
                        Image.network(
                          userModel.backgroundImage ?? "",
                          width: double.maxFinite,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                userModel.status?.statusToImageUrl(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Durum: ${userModel.status?.translateStatusEnum()}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  if (userModel.status == StatusEnum.success)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "İsim: ${userModel.name}",
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Soyisim: ${userModel.surname}",
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Kütük: ${userModel.city}",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                ]),
          ),
          Center(
            child: SizedBox(
              width: 250,
              child: ElevatedButton.icon(
                  onPressed: () async {
                    setState(() {
                      userModel = userModel.copyWith(istimeOut: true);
                    });
                    await init().whenComplete(() => setState(() {}));
                  },
                  icon: userModel.status == StatusEnum.waiting
                      ? const LoadingWidget()
                      : const Icon(Icons.start),
                  label: const Text("Kullanıcı verisini çek!")),
            ),
          )
        ],
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
      width: 20,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}


// Haber uygulaması
// Quiz uygulaması
// Todo uygulaması *belki
// İngilizce Kelime ezberleme uygulaması

