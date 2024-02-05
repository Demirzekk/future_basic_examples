import 'package:future_basic_examples/extension/extensions.dart';

class UserModel {
  StatusEnum? status;
  String? name;
  String? surname;
  String? city;
  String? userAvatar;
  UserModel(
      {this.status = StatusEnum.idle,
      this.name,
      this.surname,
      this.city,
      this.userAvatar});

  @override
  String toString() {
    return 'status: $status, name: $name, surname: $surname, city: $city, userAvatar: $userAvatar';
  }
}
