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
