import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? name;
  String? username;
  String? email;
  String? password;
  String? imgpath;

  UserModel({
    this.name,
    this.username,
    this.email,
    this.password,
    this.imgpath,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
