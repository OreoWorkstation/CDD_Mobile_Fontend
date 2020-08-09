class BrowseEntity {
  int id;
  int userId;
  int articleId;
  int browseValue;
  DateTime createTime;
  DateTime updateTime;

  BrowseEntity({
    this.id,
    this.userId,
    this.articleId,
    this.browseValue,
    this.createTime,
    this.updateTime,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "articleId": articleId,
        "browseValue": browseValue,
        "createTime": createTime == null ? "" : createTime.toIso8601String(),
        "updateTime": updateTime == null ? "" : createTime.toIso8601String(),
      };
}
