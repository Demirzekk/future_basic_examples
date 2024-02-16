enum UserNameStatusEnum {
  userNameNotEmpty,
  userNameMinChar,
  userNameMaxChar,
  userNameNotSpecialChar,
  smallChar,
  isStartWithNum,
  userNameBetweenSpace
}

enum PassStatusEnum {
  passValid,
  passHasMinChar,
  passSpecialChar,
  passHasNumber,
  passHasText,
  passNotEmpty
}

enum StatusEnum { idle, waiting, success, failure, timeOut }
enum ValidationKey { userNameExample, userNameWord, passWordExample,passEnter, passWordKey, save }

enum AssetsImageEnum { loading }
