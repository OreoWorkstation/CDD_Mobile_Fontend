class FollowEntity {
  int id;
  int userId;
  int followedId;
  DateTime createTime;
  DateTime updateTime;

  FollowEntity({
    this.id,
    this.userId,
    this.followedId,
    this.createTime,
    this.updateTime,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "followedId": followedId,
        "createTime": createTime == null ? "" : createTime.toIso8601String(),
        "updateTime": updateTime == null ? "" : updateTime.toIso8601String(),
      };
}

class FollowReponseEntity {
  int userId;
  String nickname;
  String avatar;
  int gender;
  String introduction;

  FollowReponseEntity({
    this.userId,
    this.nickname,
    this.avatar,
    this.gender,
    this.introduction,
  });

  factory FollowReponseEntity.fromJson(Map<String, dynamic> json) =>
      FollowReponseEntity(
        userId: json["userId"],
        nickname: json["nickname"],
        avatar: json["avatar"],
        gender: json["gender"],
        introduction: json["introduction"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "nickname": nickname,
        "avatar": avatar,
        "gender": gender,
        "introduction": introduction,
      };
}
