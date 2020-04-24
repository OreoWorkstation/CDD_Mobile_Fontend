class UserLoginRequestEntity {
  String account;
  String password;

  UserLoginRequestEntity({
    this.account,
    this.password,
  });

  factory UserLoginRequestEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginRequestEntity(
        account: json["account"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "account": account,
        "password": password,
      };
}
