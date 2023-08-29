// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      messageId: json['messageId'] as String?,
      fromId: json['fromId'] as String?,
      userId: json['userId'] as String?,
      time: json['time'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'fromId': instance.fromId,
      'userId': instance.userId,
      'time': instance.time,
      'message': instance.message,
    };
