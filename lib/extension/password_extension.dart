enum PassStatusEnum { idle, invalid, valid }

extension PasswordEnumX on PassStatusEnum {
  passAboutInfo() {
    switch (this) {
      case PassStatusEnum.idle:
        return "şifre yok";
      case PassStatusEnum.invalid:
        return "şifre geçerli değil";
      case PassStatusEnum.valid:
        return "yönlendiriliyor";
      default:
        return "herhangi bir durum belirlenemedi.";
    }
  }
}

