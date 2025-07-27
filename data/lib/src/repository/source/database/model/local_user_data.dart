import 'local_image_url_data.dart';

class LocalUserData {
  LocalUserData({
    this.id,
    this.email,
    this.money,
    this.gender,
    this.birthday,
    this.avatar,
    List<LocalImageUrlData>? photos,
  }) : photos = photos ?? [];

  int? id;
  String? email;
  String? money;
  int? gender;
  int? birthday;

  LocalImageUrlData? avatar;
  List<LocalImageUrlData> photos;

  Map<String, Object?> toMap() => {
        'id': id,
        'email': email,
        'money': money,
        'gender': gender,
        'birthday': birthday,
      };

  factory LocalUserData.fromMap(
    Map<String, Object?> map, {
    LocalImageUrlData? avatar,
    List<LocalImageUrlData>? photos,
  }) =>
      LocalUserData(
        id: map['id'] as int?,
        email: map['email'] as String?,
        money: map['money'] as String?,
        gender: map['gender'] as int?,
        birthday: map['birthday'] as int?,
        avatar: avatar,
        photos: photos,
      );

  @override
  int get hashCode {
    return id.hashCode ^ email.hashCode ^ money.hashCode ^ gender.hashCode ^ birthday.hashCode;
  }

  @override
  String toString() {
    return 'LocalUserData(id: \$id, email: \$email, money: \$money, gender: \$gender, birthday: \$birthday)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is LocalUserData &&
        other.id == id &&
        other.email == email &&
        other.money == money &&
        other.gender == gender &&
        other.birthday == birthday;
  }
}
