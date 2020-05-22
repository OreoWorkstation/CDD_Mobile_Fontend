class ArticleResponseEntity {
  int id;
  int expertId;
  String expertName;
  String expertAvatar;
  String title;
  String thumbnail;
  String content;
  int category;
  int browseValue;
  DateTime createTime;
  DateTime updateTime;

  ArticleResponseEntity({
    this.id,
    this.expertId,
    this.expertName,
    this.expertAvatar,
    this.title,
    this.thumbnail,
    this.content,
    this.category,
    this.browseValue,
    this.createTime,
    this.updateTime,
  });

  factory ArticleResponseEntity.fromJson(Map<String, dynamic> json) =>
      ArticleResponseEntity(
        id: json["id"],
        expertId: json["expertId"],
        expertName: json["expertName"],
        expertAvatar: json["expertAvatar"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        content: json["content"],
        category: json["category"],
        browseValue: json["browseValue"],
        createTime: DateTime.parse(json["createTime"]),
        updateTime: DateTime.parse(json["updateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "expertId": expertId,
        "expertName": expertName,
        "expertAvatar": expertAvatar,
        "title": title,
        "thumbnail": thumbnail,
        "content": content,
        "category": category,
        "browseValue": browseValue,
        "createTime": createTime == null ? "" : createTime.toIso8601String(),
        "updateTime": updateTime == null ? "" : createTime.toIso8601String(),
      };
}
