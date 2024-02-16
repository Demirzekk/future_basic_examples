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
    var key = password?.split("").contains(" ") == true;
    return key;
  }

  // satır başında sayısal ifadeyi engelle
  bool startNumericalChar(String? password) {
    String pattern = '^[0-9]';
    if(password?.substring(0, 1).contains(pattern) == false ){}

    if (password?.substring(0, 1).contains(pattern) == true) {
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
