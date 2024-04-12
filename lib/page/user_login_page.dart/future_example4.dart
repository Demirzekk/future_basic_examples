import 'package:flutter/material.dart';
import 'package:future_basic_examples/init/extension/extensions.dart';

import '../../init/constants/app_data.dart';
import '../../init/custom_widgets/custom_text_field_pass.dart';
import '../../init/enum/app_enum.dart';

import '../../init/model/password_model.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    hintText:
                        validationKey.translate(ValidationKey.userNameWord),
                    title:
                        validationKey.translate(ValidationKey.userNameExample),
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
                    hintText:
                        validationKey.translate(ValidationKey.passWordExample),
                    title: validationKey.translate(ValidationKey.passWordKey),
                  ),
                ],
              )),
          if (passStatusList.isEmpty && passWordController.text.isNotEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4),
              child: Text(
                "Oluşturulan şifre geçerli!",
                style:
                    TextStyle(color: Color.fromARGB(255, 3, 5, 3), fontWeight: FontWeight.w600),
              ),
            ),
          ElevatedButton(
              onPressed: () {
                final form = formKey.currentState;
                if (form?.validate() == false) {
                  return;
                }
              },
              child: Text(validationKey.translate(ValidationKey.save))),
        ],
      ),
    );
  }
}
