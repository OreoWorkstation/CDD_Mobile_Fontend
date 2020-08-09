class FansEntity {
  int id;
  int userId;
  int fansId;
  DateTime createTime;
  DateTime updateTime;

  FansEntity({
    this.id,
    this.userId,
    this.fansId,
    this.createTime,
    this.updateTime,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "fansId": fansId,
        "createTime": createTime == null ? "" : createTime.toIso8601String(),
        "updateTime": updateTime == null ? "" : updateTime.toIso8601String(),
      };
}
