/// 用户登录请求
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

/// 用户登录响应
class UserLoginResponseEntity {
  int code;
  dynamic data;
  String msg;

  UserLoginResponseEntity({
    this.code,
    this.data,
    this.msg,
  });

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseEntity(
        code: json["code"],
        data: json["data"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data,
        "msg": msg,
      };
}
