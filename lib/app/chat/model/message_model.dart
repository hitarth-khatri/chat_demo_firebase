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
    required this.sentTime,
  });

  factory MessageModel.fromJson(Map<dynamic, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<dynamic, dynamic> toJson() => _$MessageModelToJson(this);
}
