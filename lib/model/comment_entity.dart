class CommentEntity {
  int userId;
  String userAvatar;
  String userNickname;
  int parentId;
  String parentNickname;
  String content;
  DateTime createTime;

  CommentEntity({
    this.userId,
    this.userAvatar,
    this.userNickname,
    this.parentId,
    this.parentNickname,
    this.content,
    this.createTime,
  });

  factory CommentEntity.fromJson(Map<String, dynamic> json) => CommentEntity(
        userId: json["userId"],
        userAvatar: json["userAvatar"],
        userNickname: json["userNickname"],
        parentId: json["parentId"],
        parentNickname: json["parentNickname"],
        content: json["content"],
        createTime: DateTime.parse(json["createTime"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userAvatar": userAvatar,
        "userNickname": userNickname,
        "parentId": parentId,
        "parentNickname": parentNickname,
        "content": content,
        "createTime": createTime == null ? "" : createTime.toIso8601String(),
      };
}

class Comment {
  int id;
  int instantId;
  int userId;
  int parentId;
  String content;
  DateTime createTime;
  DateTime updateTime;

  Comment({
    this.id,
    this.instantId,
    this.userId,
    this.parentId,
    this.content,
    this.createTime,
    this.updateTime,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json['id'],
        instantId: json['instantId'],
        userId: json["userId"],
        parentId: json["parentId"],
        content: json["content"],
        createTime: DateTime.parse(json["createTime"]),
        updateTime: DateTime.parse(json["updateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "instantId": instantId,
        "userId": userId,
        "parentId": parentId,
        "content": content,
        "createTime": createTime == null ? "" : createTime.toIso8601String(),
        "updateTime": updateTime == null ? "" : updateTime.toIso8601String(),
      };
}
