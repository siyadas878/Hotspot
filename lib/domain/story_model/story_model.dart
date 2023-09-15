class StoryModel {
  String? imgUrl;
  String? id;
  String? time;
  String? postId;

  StoryModel({this.imgUrl, this.id, this.time, this.postId});

  StoryModel.fromJson(Map<String, dynamic> json) {
    imgUrl = json['imgUrl'];
    id = json['id'];
    time = json['time'];
    postId = json['postId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['imgUrl'] = imgUrl;
    data['id'] = id;
    data['time'] = time;
    data['postId'] = postId;
    return data;
  }
}