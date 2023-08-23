import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  String? caption;
  String? imgUrl;
  String? time;
  String? userId;
  String? postId;
  List<String>? like;
  List<String>? followers;
  List<String>? following;

  PostModel(
      {this.caption,
      this.imgUrl,
      this.userId,
      this.time,
      this.like,
      this.postId,
      this.followers,
      this.following});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return _$PostModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
