 

import '../enum/app_enum.dart';
 

const String userPicture = "https://picsum.photos/1200";

class UserModel {
  StatusEnum? status;
  String? name;
  String? surname;
  String? city;
  String? userAvatar;
  String? backgroundImage;
  bool? istimeOut;
  UserModel(
      {this.status = StatusEnum.idle,
      this.name,
      this.surname,
      this.city,
      this.userAvatar,
      this.istimeOut,
      this.backgroundImage = userPicture});

  UserModel copyWith({
    StatusEnum? status,
    String? name,
    String? surname,
    String? city,
    String? userAvatar,
    String? backgroundImage,
    bool? istimeOut,
  }) {
    return UserModel(
        status: status ?? this.status,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        city: city ?? this.city,
        userAvatar: userAvatar ?? this.userAvatar,
        istimeOut: istimeOut ?? this.istimeOut,
        backgroundImage: backgroundImage ?? this.backgroundImage);
  }

  @override
  String toString() {
    return 'UserModel(status: $status, name: $name, surname: $surname, city: $city, userAvatar: $userAvatar, backgroundImage: $backgroundImage)';
  }
}
