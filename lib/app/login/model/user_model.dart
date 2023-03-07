import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String uid;
  String name;
  String email;
  String profileUrl;
  String lastMessage;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profileUrl,
    this.lastMessage = "",
  });

  factory UserModel.fromJson(Map<dynamic, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<dynamic, dynamic> toJson() => _$UserModelToJson(this);
}
