import 'package:flutter/material.dart';
import 'package:future_basic_examples/init/extension/extensions.dart';

import '../init/custom_widgets/custom_text_field_pass.dart';
import '../init/enum/app_enum.dart';

import '../init/model/password_model.dart';

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
  List<UserNameStatusEnum?> userNameStatusList = [];
  @override
  void initState() {
    super.initState();
  }
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
                      setState(() {
                        userNameStatusList = userName.userNameValid();
                      });
                      if (userNameStatusList.isEmpty) {
                        return null;
                      }
                      return userNameStatusList.first?.userNameStatusInfo();
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

// TODO taşınamadı
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
