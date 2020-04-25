/// 用户注册请求
class UserRegisterRequestEntity {
  String account;
  String password;
  String nickname;
  String avatar;

  UserRegisterRequestEntity({
    this.account,
    this.password,
    this.nickname = "Scott Wong",
    this.avatar,
  });

  factory UserRegisterRequestEntity.fromJson(Map<String, dynamic> json) =>
      UserRegisterRequestEntity(
        account: json["account"],
        password: json["password"],
        nickname: json["nickname"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "account": account,
        "password": password,
        "nickname": nickname,
        "avatar": avatar,
      };
}
