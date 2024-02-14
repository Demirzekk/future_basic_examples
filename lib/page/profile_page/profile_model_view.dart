import 'package:future_basic_examples/page/profile_page/profile_model.dart';

class ProfileModelView {
  Future<ProfileModel> setProfileModelData() async {
    await Future.delayed(const Duration(seconds: 2));
    return ProfileModel(profileTitle: "Zamanlama takvimi");
  }
}
