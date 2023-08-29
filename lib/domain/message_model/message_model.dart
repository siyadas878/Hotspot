import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  String? messageId;
  String? fromId;
  String? userId;
  String? time;
  String? message;

  MessageModel({
    this.messageId,
    this.fromId,
    this.userId,
    this.time,
    this.message,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return _$MessageModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
