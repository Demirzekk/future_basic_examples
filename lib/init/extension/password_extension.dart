import '../validator/validator.dart';

enum PassStatusEnum {
  passValid,
  passHasMinChar,
  passSpecialChar,
  passHasNumber,
  passHasText,
  passNotEmpty
}

enum UserNameStatusEnum { usernameEmpty }

extension PasswordEnumX on String? {
  List<PassStatusEnum?> passValid() {
    final CustomValidator validor = CustomValidator();
    List<PassStatusEnum?> passStatusList = [];
    if (validor.isValEmptyOrNull(this) == true) {
      passStatusList.add(PassStatusEnum.passNotEmpty);
    }
    if (validor.hasMinLength(this, minLength: 8) == false) {
      passStatusList.add(PassStatusEnum.passHasMinChar);
    }

    if (validor.hasMinNumericChar(this) == false) {
      passStatusList.add(PassStatusEnum.passHasNumber);
    }
    if (validor.hasMinNormalChar(this) == false) {
      passStatusList.add(PassStatusEnum.passHasText);
    }
    if (validor.hasMinSpecialChar(this) == false) {
      passStatusList.add(PassStatusEnum.passSpecialChar);
    }

    return passStatusList;
  }
}

extension AssetsX on String? {
  String toJsonAsset() {
    return "assets/lottie/$this.json";
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

extension UserNameValidatorX on String? {
  List<UserNameStatusEnum?> usernameValid() {
    // final CustomValidator validor = CustomValidator();
    List<UserNameStatusEnum?> userNameStatusList = [];
    //TODO Turan Ödev
    // username en az 6 karakter uzunluğunda olmalı 15 karakterden fazla olmamalı,
    // büyük karakter içermemeli,
    // tüm karakterlerin küçük olması gerek
    // ahmet muhsin gibi arasında boşluk olmamalı
    // özel karakter içermemeli
    // sayi içerebilir ama başında olmamalı
//TODO ödev2 
// enumlar vs klasörlere taşınacak
    return userNameStatusList;
  }
}


