extension ValidatorX on String? {
  bool isValEmptyOrNull() {
    return this?.isEmpty == true || this == "" || this == null;
  }

  // minumum uzunlukta mı?
  bool hasMinLength({int minLength = 8}) {
    return (this?.length ?? 0) >= minLength ? true : false;
  }

  /// Checks if password has at least normal char letter matches
  /// mininum normal karakter var mı?
  bool hasMinNormalChar({int normalCount = 1}) {
    String pattern = '^(.*?[A-Z]){$normalCount,}';
    return this?.toUpperCase().contains(RegExp(pattern)) == true;
  }

  bool isValidEmail() {
    return this != "";
  }

  // maximum normal karakter var mı?
  bool hasMaxLenght({int maxCount = 1}) {
    String pattern = '^(.*?[A-Z]){$maxCount,}';
    return this?.toUpperCase().contains(RegExp(pattern)) == true;
  }

  /// Checks if password has at least uppercaseCount uppercase letter matches
  /// minumum büyük harf var mı?
  bool hasMinUppercase({int uppercaseCount = 1}) {
    String pattern = '^(.*?[A-Z]){$uppercaseCount,}';
    return this?.contains(RegExp(pattern)) == true;
  }

  /// Checks if password has at least lowercaseCount lowercase letter matches
  /// minumum küçük harf var mı?
  bool hasMinLowercase({int lowercaseCount = 1}) {
    String pattern = '^(.*?[a-z]){$lowercaseCount,}';
    return this?.contains(RegExp(pattern)) == true;
  }

  /// Checks if password has at least numericCount numeric character matches
  /// minumum rakam içeriyor mu?
  bool hasMinNumericChar({int numericCount = 1, bool specialChar = true}) {
    String pattern = '^(.*?[0-9]){$numericCount,}';
    return this?.contains(RegExp(pattern)) == specialChar;
  }

  //Checks if password has at least specialCount special character matches
  // minimum özel karakter var mı?
  bool hasMinSpecialChar({int specialCount = 1}) {
    String pattern =
        // ignore: prefer_interpolation_to_compose_strings
        r"^(.*?[$&+,\:;/=?@#*|'<>.^()_%!-]){" + specialCount.toString() + "}";
    bool res = this?.contains(RegExp(pattern)) == true;
    return res;
  }

  // kelimeler arası boşluk kaldırma.

  bool notSpaceChar() {
    var key = this?.contains(" ") == true;
    return key;
  }

  // satır başında sayısal ifadeyi engelle
  bool startNumericalChar() {
    // sayi ile mi başlıyor
    final RegExp regex = RegExp(r'^\d');
    if (this?.contains(regex) == true) {
      return true;
    }

    return false;
  }

  // bütün karakterler küçük olmalıdır
  bool hasLowerCaseChar() {
    final result = this?.toLowerCase() == this;
    return result;
  }
}

class CustomValidator {
  bool isValEmptyOrNull(String? password) {
    return password?.isEmpty == true || password == "" || password == null;
  }

  // minumum uzunlukta mı?
  bool hasMinLength(String? password, {int minLength = 8}) {
    return (password?.length ?? 0) >= minLength ? true : false;
  }

  /// Checks if password has at least normal char letter matches
  /// mininum normal karakter var mı?
  bool hasMinNormalChar(String? password, {int normalCount = 1}) {
    String pattern = '^(.*?[A-Z]){$normalCount,}';
    return password?.toUpperCase().contains(RegExp(pattern)) == true;
  }

  bool isValidEmail(String? email) {
    return false;
  }

  // maximum normal karakter var mı?
  bool hasMaxLenght(String? password, {int maxCount = 1}) {
    String pattern = '^(.*?[A-Z]){$maxCount,}';
    return password?.toUpperCase().contains(RegExp(pattern)) == true;
  }

  /// Checks if password has at least uppercaseCount uppercase letter matches
  /// minumum büyük harf var mı?
  bool hasMinUppercase(String? password, {int uppercaseCount = 1}) {
    String pattern = '^(.*?[A-Z]){$uppercaseCount,}';
    return password?.contains(RegExp(pattern)) == true;
  }

  /// Checks if password has at least lowercaseCount lowercase letter matches
  /// minumum küçük harf var mı?
  bool hasMinLowercase(String? password, {int lowercaseCount = 1}) {
    String pattern = '^(.*?[a-z]){$lowercaseCount,}';
    return password?.contains(RegExp(pattern)) == true;
  }

  /// Checks if password has at least numericCount numeric character matches
  /// minumum rakam içeriyor mu?
  bool hasMinNumericChar(String? password,
      {int numericCount = 1, bool specialChar = true}) {
    String pattern = '^(.*?[0-9]){$numericCount,}';
    return password?.contains(RegExp(pattern)) == specialChar;
  }

  //Checks if password has at least specialCount special character matches
  // minimum özel karakter var mı?
  bool hasMinSpecialChar(String? password, {int specialCount = 1}) {
    String pattern =
        // ignore: prefer_interpolation_to_compose_strings
        r"^(.*?[$&+,\:;/=?@#*|'<>.^()_%!-]){" + specialCount.toString() + "}";
    bool res = password?.contains(RegExp(pattern)) == true;
    return res;
  }

  // kelimeler arası boşluk kaldırma.

  bool notSpaceChar(String? password) {
    var key = password?.contains(" ") == true;
    return key;
  }

  // satır başında sayısal ifadeyi engelle
  bool startNumericalChar(String? arg) {
    // sayi ile mi başlıyor
    final RegExp regex = RegExp(r'^\d');
    if (arg?.contains(regex) == true) {
      return true;
    }

    return false;
  }

  // bütün karakterler küçük olmalıdır
  bool hasLowerCaseChar(String? password) {
    var kel = password?.contains(password.toLowerCase());
    if (kel == false) {
      return true;
    }
    return false;
  }
}
