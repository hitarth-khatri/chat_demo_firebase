// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<dynamic, dynamic> json) => UserModel(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profileUrl: json['profileUrl'] as String,
      lastMessage: json['lastMessage'] as String? ?? "",
      lastMessageType: json['lastMessageType'] as String? ?? "message",
    );

Map<dynamic, dynamic> _$UserModelToJson(UserModel instance) => <dynamic, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'profileUrl': instance.profileUrl,
      'lastMessage': instance.lastMessage,
      'lastMessageType': instance.lastMessageType,
    };
