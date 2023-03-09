import 'package:chat_demo_firebase/common/constants/app_strings.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  String senderId;
  String senderEmail;
  String senderName;
  String senderProfile;

  String receiverId;
  String receiverEmail;
  String receiverName;
  String receiverProfile;

  String message;
  String messageType;
  DateTime sentTime;

  MessageModel({
    required this.senderId,
    required this.senderEmail,
    required this.senderName,
    required this.senderProfile,
    required this.receiverId,
    required this.receiverEmail,
    required this.receiverName,
    required this.receiverProfile,
    required this.message,
    this.messageType = AppStrings.messageTypeMessage,
    required this.sentTime,
  });

  factory MessageModel.fromJson(Map<dynamic, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<dynamic, dynamic> toJson() => _$MessageModelToJson(this);
}
