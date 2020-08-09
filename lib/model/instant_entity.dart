class InstantVO {
  String nickname;
  String avatar;
  int status;
  InstantEntity instant;

  InstantVO({
    this.nickname,
    this.avatar,
    this.status,
    this.instant,
  });

  factory InstantVO.fromJson(Map<String, dynamic> json) => InstantVO(
    nickname: json["nickname"],
    avatar: json["avatar"],
    status: json["status"],
    instant: InstantEntity.fromJson(json["instant"]),
  );

  Map<String, dynamic> toJson() => {
    "nickname": nickname,
    "avatar": avatar,
    "status": status,
    "instant": instant.toJson(),
  };
}

class InstantEntity {
  int id;
  int userId;
  String content;
  String imagePath;
  String videoPath;
  String audioPath;
  int likeNumber;
  int commentNumber;
  DateTime createTime;
  DateTime updateTime;

  InstantEntity({
    this.id,
    this.userId,
    this.content,
    this.imagePath,
    this.videoPath,
    this.audioPath,
    this.likeNumber,
    this.commentNumber,
    this.createTime,
    this.updateTime,
  });

  factory InstantEntity.fromJson(Map<String, dynamic> json) => InstantEntity(
    id: json["id"],
    userId: json["userId"],
    content: json["content"],
    imagePath: json["imagePath"],
    videoPath: json["videoPath"],
    audioPath: json["audioPath"],
    likeNumber: json["likeNumber"],
    commentNumber: json["commentNumber"],
    createTime: DateTime.parse(json["createTime"]),
    updateTime: DateTime.parse(json["updateTime"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "content": content,
    "imagePath": imagePath,
    "videoPath": videoPath,
    "audioPath": audioPath,
    "likeNumber": likeNumber,
    "commentNumber": commentNumber,
    "createTime": createTime == null ? "" : createTime.toIso8601String(),
    "updateTime": updateTime == null ? "" : updateTime.toIso8601String(),
  };
}
