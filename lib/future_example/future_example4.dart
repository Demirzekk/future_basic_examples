import 'package:flutter/material.dart';
import 'package:future_basic_examples/extension/password_extension.dart';

import 'package:future_basic_examples/model/password_model.dart';
import 'package:lottie/lottie.dart';

class PassWordPage extends StatefulWidget {
  const PassWordPage({super.key});

  @override
  State<PassWordPage> createState() => _PassWordPageState();
}

class _PassWordPageState extends State<PassWordPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  PassWordModel passModel = PassWordModel();
  GlobalKey<FormState> formKey = GlobalKey();
  Future init() async {
    setState(() {});
    passModel.status = PassStatusEnum.idle;
    final formQuery = formKey.currentState;
    if (formQuery?.validate() == false) {
      return passModel.status = PassStatusEnum.invalid;
    }

    passModel = PassWordModel(
        password: passWordController.text, userName: userNameController.text);
    passModel.status = PassStatusEnum.valid;

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
            title: Text(passModel.status?.passAboutInfo()),
            content: SizedBox(
                height: 100,
                width: 100,
                child: SizedBox(
                    height: 30,
                    width: 30,
                    child:
                        LottieBuilder.asset("assets/lottie/loading.json")))));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "şifre belirleyin ${passModel.status == null ? "" : passModel.status?.passAboutInfo()}"),
      ),
      body: Column(
        children: [
          Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextFieldPass(
                    controller: userNameController,
                    hintText: "mustafacimen",
                    title: "Kullanıcı Adı",
                  ),
                  CustomTextFieldPass(
                    textValidator: (passVal) {
                      if (passVal?.length != 8 ||
                          passVal?.isEmpty == true ||
                          passVal?.contains(RegExp(r'^[a-zA-Z0-9]+$')) ==
                              true) {
                        return "uyarı: en az bir büyük ve küçük harf bulunmalı, en az bir özel karakter, en az bir rakam bulunmalı";
                      }
                      return null;
                    },
                    controller: passWordController,
                    hintText: "ör  istanBul.2024",
                    title: "Şifre",
                  ),
                ],
              )),
          ElevatedButton(
              onPressed: () {
                init();
              },
              child: const Text("kaydet"))
        ],
      ),
    );
  }
}

class CustomTextFieldPass extends StatelessWidget {
  const CustomTextFieldPass(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.title,
      this.textValidator});
  final TextEditingController controller;
  final String hintText;
  final String title;
  final String? Function(String?)? textValidator;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextFormField(
            validator: textValidator,
            decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
            controller: controller,
          ),
        ),
      ],
    );
  }
}
