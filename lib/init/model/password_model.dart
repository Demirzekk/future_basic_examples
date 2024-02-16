

 


import '../enum/app_enum.dart';

class PassWordModel {
  PassStatusEnum? status;
  String? userName;
  String? password;
  PassWordModel({
    this.status,
    this.userName,
    this.password,
  });

  @override
  String toString() =>
      'PassWordModel(userName: $userName, password: $password, status : $status)';

  PassWordModel copyWith({
    PassStatusEnum? status,
    String? userName,
    String? password,
  }) {
    return PassWordModel(
      status: status ?? this.status,
      userName: userName ?? this.userName,
      password: password ?? this.password,
    );
  }
}


