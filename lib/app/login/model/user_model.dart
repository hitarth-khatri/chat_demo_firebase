import 'package:chat_demo_firebase/common/constants/app_strings.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String uid;
  String name;
  String email;
  String profileUrl;
  String lastMessage;
  String lastMessageType;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profileUrl,
    this.lastMessage = "",
    this.lastMessageType = AppStrings.messageTypeMessage,
  });

  factory UserModel.fromJson(Map<dynamic, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<dynamic, dynamic> toJson() => _$UserModelToJson(this);
}
