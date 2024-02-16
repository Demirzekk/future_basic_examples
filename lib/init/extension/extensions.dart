// enumlar bizim için bir olayı veya durumu işaretlememize yardımcı olur

import 'package:future_basic_examples/init/constants/url_constants.dart';

import '../enum/app_enum.dart';
import '../validator/validator.dart';

UrlConstants urlconst = UrlConstants();

enum StatusEnum { idle, waiting, success, failure, timeOut }

extension StatusEnumX on StatusEnum {
  translateStatusEnum() {
    switch (this) {
      case StatusEnum.idle:
        return "Bağlanmak için dokunun";
      case StatusEnum.waiting:
        return "Bağlantı Bekliyor";
      case StatusEnum.success:
        return "Bağlandı";
      case StatusEnum.failure:
        return "Bir hata meydana geldi";
      case StatusEnum.timeOut:
        return "İşlem zaman aşımı";
      default:
        return "Null Status";
    }
  }
}

extension StatusImageX on StatusEnum {
  statusToImageUrl() {
    switch (this) {
      case StatusEnum.idle:
        return urlconst.image;
      case StatusEnum.waiting:
        return urlconst.loadingImage;
      case StatusEnum.success:
        return urlconst.userAvatar;
      case StatusEnum.failure:
        return urlconst.errorImage;

      default:
        return urlconst.image;
    }
  }
}

extension EnableTimeOutX on bool? {
  enableTimeout() {
    switch (this) {
      case true:
        return StatusEnum.timeOut;
      case false:
        return StatusEnum.success;

      default:
        return StatusEnum.idle;
    }
  }
}

extension UserNameEnumX on String? {
  List<UserNameStatusEnum?> userNameValid() {
    final CustomValidator validatorUserName = CustomValidator();
    List<UserNameStatusEnum> userNameValidList = [];

    if (validatorUserName.isValEmptyOrNull(
          this,
        ) ==
        true) {
      userNameValidList.add(UserNameStatusEnum.userNameNotEmpty);
    }

    if (validatorUserName.hasMinLength(this, minLength: 6) == false) {
      userNameValidList.add(UserNameStatusEnum.userNameMinChar);
    }

    if (validatorUserName.hasMaxLenght(this, maxCount: 15) == true) {
      userNameValidList.add(UserNameStatusEnum.userNameMaxChar);
    }

    if (validatorUserName.hasLowerCaseChar(this) == true) {
      userNameValidList.add(UserNameStatusEnum.smallChar);
    }

    if (validatorUserName.notSpaceChar(this) == true) {
      userNameValidList.add(UserNameStatusEnum.userNameBetweenSpace);
    }

    /// ??????///////////// ⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️

    if (validatorUserName.startNumericalChar(this) == true) {
      userNameValidList.add(UserNameStatusEnum.maybeContainNum);
    }

    //// ?????????????//////⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️

    if (validatorUserName.hasMinSpecialChar(this)) {
      userNameValidList.add(UserNameStatusEnum.userNameNotSpecialChar);
    }
    return userNameValidList;
  }
}

extension UserNameStatusEnumX on UserNameStatusEnum {
  String userNameStatusInfo() {
    switch (this) {
      case UserNameStatusEnum.userNameNotEmpty:
        return "Kullanıcı adı boş olamaz!";
      case UserNameStatusEnum.userNameMinChar:
        return "En az 6 karakter girmelisiniz!";
      case UserNameStatusEnum.userNameMaxChar:
        return "En fazla 15 karakter girebilirsin!";

      case UserNameStatusEnum.userNameNotSpecialChar:
        return "Özel karakter girmemelisin!";
      case UserNameStatusEnum.smallChar:
        return "Bütün karakterler küçük olmalıdır!";

      case UserNameStatusEnum.userNameBetweenSpace:
        return "Karakterler arası boşluk olamaz!";
      case UserNameStatusEnum.maybeContainNum:
        return "Kullanıcı adının başında rakam olamaz";

      default:
        return "Şifrenizi kurallara uygun oluşturun!";
    }
  }
}

extension PasswordEnumX on String? {
  List<PassStatusEnum?> passValid() {
    final CustomValidator validor = CustomValidator();
    List<PassStatusEnum?> passStatusList = [];
    if (validor.isValEmptyOrNull(this) == true) {
      passStatusList.add(PassStatusEnum.passNotEmpty);
    }
    if (validor.hasMinLength(this, minLength: 6) == false) {
      passStatusList.add(PassStatusEnum.passHasMinChar);
    }

    if (validor.hasMinNormalChar(this) == false) {
      passStatusList.add(PassStatusEnum.passHasText);
    }
    if (validor.hasMinSpecialChar(this) == true) {
      passStatusList.add(PassStatusEnum.passSpecialChar);
    }

    return passStatusList;
  }
}

extension PassValidX on PassStatusEnum {
  String passStatusToDesc() {
    switch (this) {
      case PassStatusEnum.passNotEmpty:
        return "Şifre alanı boş olamaz!";
      case PassStatusEnum.passHasMinChar:
        return "En az 8 karakter girmelisiniz!";
      case PassStatusEnum.passHasNumber:
        return "En az 1 adet sayı girmelisiniz!";

      case PassStatusEnum.passHasText:
        return "En az 1 adet harf girmelisiniz";
      case PassStatusEnum.passSpecialChar:
        return "En az 1 adet özel karakter girmelisiniz!";

      case PassStatusEnum.passValid:
        return "Şifreniz kullanıma uygun!";
      default:
        return "Şifrenizi kurallara uygun oluşturun!";
    }
  }
}

extension AssetsX on String? {
  String toJsonAsset() {
    return "assets/lottie/$this.json";
  }
}

extension AssetX on AssetsImageEnum {
  String loadingAssets() {
    return "assets/lottie/$name.json";
  }
}
