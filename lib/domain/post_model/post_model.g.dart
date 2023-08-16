// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      caption: json['caption'] as String?,
      imgUrl: json['imgUrl'] as String?,
      userId: json['id'] as String?,
      time: json['time'] as String?,
      postId: json['postId'] as String?,
      like: (json['like'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'caption': instance.caption,
      'imgUrl': instance.imgUrl,
      'userId': instance.userId,
      'time': instance.time,
      'like': instance.like,
      'postId':instance.postId
    };
