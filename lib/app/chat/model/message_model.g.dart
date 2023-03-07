// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<dynamic, dynamic> json) => MessageModel(
      senderId: json['senderId'] as String,
      senderEmail: json['senderEmail'] as String,
      senderName: json['senderName'] as String,
      senderProfile: json['senderProfile'] as String,
      receiverId: json['receiverId'] as String,
      receiverEmail: json['receiverEmail'] as String,
      receiverName: json['receiverName'] as String,
      receiverProfile: json['receiverProfile'] as String,
      message: json['message'] as String,
      sentTime: DateTime.parse(json['sentTime'] as String),
    );

Map<dynamic, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <dynamic, dynamic>{
      'senderId': instance.senderId,
      'senderEmail': instance.senderEmail,
      'senderName': instance.senderName,
      'senderProfile': instance.senderProfile,
      'receiverId': instance.receiverId,
      'receiverEmail': instance.receiverEmail,
      'receiverName': instance.receiverName,
      'receiverProfile': instance.receiverProfile,
      'message': instance.message,
      'sentTime': instance.sentTime.toIso8601String(),
    };
