

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
  bool hasMinNumericChar(String? password, {int numericCount = 1}) {
    String pattern = '^(.*?[0-9]){$numericCount,}';
    return password?.contains(RegExp(pattern)) == true;
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
}
