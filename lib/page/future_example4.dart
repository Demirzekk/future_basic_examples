import 'package:flutter/material.dart';

import '../init/extension/password_extension.dart';
import '../init/model/password_model.dart';
import '../init/validator/validator.dart';

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
  List<PassStatusEnum?> passStatusList = [];
  // Future init() async {
  //   setState(() {});
  //   passModel.status = PassStatusEnum.idle;
  //   final formQuery = formKey.currentState;
  //   if (formQuery?.validate() == false) {
  //     return passModel.status = PassStatusEnum.invalid;
  //   }

  //   passModel = PassWordModel(
  //       password: passWordController.text, userName: userNameController.text);
  //   passModel.status = PassStatusEnum.valid;

  //   showDialog(
  //       context: context,
  //       builder: (_) => AlertDialog(
  //           title: Text(passModel.status?.passAboutInfo()),
  //           content: SizedBox(
  //               height: 100,
  //               width: 100,
  //               child: SizedBox(
  //                   height: 30,
  //                   width: 30,
  //                   child: LottieBuilder.asset(
  //                       AssetsImageEnum.loading.loadingAssets())))));

  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text(
          //     "şifre belirleyin ${passModel.status == null ? "" : passModel.status?.passAboutInfo()}"),
          ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextFieldPass(
                    controller: userNameController,
                    hintText: Key.userNameExample.translate(),
                    title: Key.userNameWord.translate(),
                    textValidator: (userName) {
                      CustomValidator validator = CustomValidator();
                      if (validator.isValEmptyOrNull(userName)) {
                        return "uyarı \n Kullanıcı adı Boş Bırakılamaz";
                      }
                      return null;
                    },
                  ),
                  CustomTextFieldPass(
                    textValidator: (val) {
                      setState(() {
                        passStatusList = val.passValid();
                      });
                      if (passStatusList.isEmpty) {
                        return null;
                      }

                      return passStatusList.first?.passStatusToDesc();
                    },
                    controller: passWordController,
                    hintText: Key.passWordExample.translate(),
                    title: Key.passWordKey.translate(),
                  ),
                ],
              )),
          if (passStatusList.isEmpty && passWordController.text.isNotEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4),
              child: Text(
                "Oluşturulan şifre geçerli!",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
              ),
            ),
          ElevatedButton(
              onPressed: () {
                final form = formKey.currentState;
                if (form?.validate() == false) {
                  return;
                }
              },
              child: Text(Key.save.translate())),
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

enum Key { userNameExample, userNameWord, passWordExample, passWordKey, save }

extension BasicWordX on Key {
  String translate() {
    switch (this) {
      case Key.userNameExample:
        return "mustafacimen";
      case Key.userNameWord:
        return "Kullanıcı Adı Belirleyin";

      case Key.passWordExample:
        return "istanB.8";
      case Key.passWordKey:
        return "Şifre belirleyin!";
      case Key.save:
        return "kaydet";
      default:
        return "veri yok ";
    }
  }
}

enum AssetsImageEnum { loading }

extension AssetsX on AssetsImageEnum {
  String loadingAssets() {
    return "assets/lottie/$name.json";
  }
}
