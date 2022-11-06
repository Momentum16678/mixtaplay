
import 'dart:convert';

class SignupGetResponse {

  SignupGetResponse({
    required this.status,
    required this.token,
    required this.data,
  });

  String status;
  String token;
  Data data;

  factory SignupGetResponse.fromRawJson(String str) =>
      SignupGetResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignupGetResponse.fromJson(Map<String, dynamic> json) =>
      SignupGetResponse(
        status: json["status"],
        token: json["token"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "token": token,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.user,
  });

  User user;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
  };
}

class User {
  User({
    required this.id,
    required this.email,
    required this.userName,
    required this.v,
  });

  String id;
  String email;
  String userName;
  int v;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    email: json["email"],
    userName: json["username"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "userName": userName,
    "__v": v,
  };
}