class StoryModel {
  String? imgUrl;
  String? id;
  String? time;
  String? storyId;

  StoryModel({this.imgUrl, this.id, this.time, this.storyId});

  StoryModel.fromJson(Map<String, dynamic> json) {
    imgUrl = json['imgUrl'];
    id = json['id'];
    time = json['time'];
    storyId = json['storyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['imgUrl'] = imgUrl;
    data['id'] = id;
    data['time'] = time;
    data['storyId'] = storyId;
    return data;
  }
}