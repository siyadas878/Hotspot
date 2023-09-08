class NotificationModel {
  String? id;
  String? fromId;
  String? status;
  String? userId;
  String? time;

  NotificationModel(
      {this.id, this.fromId, this.status, this.userId, this.time});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromId = json['fromId'];
    status = json['status'];
    userId = json['userId'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fromId'] = fromId;
    data['status'] = status;
    data['userId'] = userId;
    data['time'] = time;
    return data;
  }
}