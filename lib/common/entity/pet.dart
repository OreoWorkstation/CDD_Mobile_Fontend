class PetEntity {
  int id;
  int userId;
  String nickname;
  int gender;
  String species;
  String avatar;
  String introduction;
  DateTime birthday;
  double weight;
  double totalCost;
  int photoNumber;
  int diaryNumber;
  DateTime createTime;
  DateTime updateTime;

  PetEntity({
    this.id,
    this.userId,
    this.nickname,
    this.gender,
    this.species,
    this.avatar,
    this.introduction,
    this.birthday,
    this.weight,
    this.totalCost,
    this.photoNumber,
    this.diaryNumber,
    this.createTime,
    this.updateTime,
  });

  factory PetEntity.fromJson(Map<String, dynamic> json) => PetEntity(
        id: json["id"],
        userId: json["userId"],
        nickname: json["nickname"],
        gender: json["gender"],
        species: json["species"],
        avatar: json["avatar"],
        introduction: json["introduction"],
        birthday: DateTime.parse(json["birthday"]),
        weight: json["weight"],
        totalCost: json["totalCost"],
        photoNumber: json["photoNumber"],
        diaryNumber: json["diaryNumber"],
        createTime: DateTime.parse(json["createTime"]),
        updateTime: DateTime.parse(json["updateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "nickname": nickname,
        "gender": gender,
        "species": species,
        "avatar": avatar,
        "introduction": introduction,
        "birthday": birthday,
        "weight": weight,
        "totalCost": totalCost,
        "photoNumber": photoNumber,
        "diaryNumber": diaryNumber,
        "createTime": createTime,
        "updateTime": updateTime,
      };
}
