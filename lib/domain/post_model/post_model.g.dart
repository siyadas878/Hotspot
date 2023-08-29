// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      caption: json['caption'] as String?,
      imgUrl: json['imgUrl'] as String?,
      userId: json['userId'] as String?,
      time: json['time'] as String?,
      like: (json['like'] as List<dynamic>?)?.map((e) => e as String).toList(),
      postId: json['postId'] as String?,
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'caption': instance.caption,
      'imgUrl': instance.imgUrl,
      'time': instance.time,
      'userId': instance.userId,
      'postId': instance.postId,
      'like': instance.like,
    };
