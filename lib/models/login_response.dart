import 'dart:convert';

import 'package:chat_app_flutter/models/user_model.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.ok,
    this.token,
    this.user,
  });

  bool ok;
  String token;
  UserModel user;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        token: json["token"],
        user: UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "token": token,
        "user": user.toJson(),
      };
}
