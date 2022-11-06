
import 'dart:convert';

class SignupPost {
  SignupPost({
    required this.username,
    required this.email,
    required this.password,
  });

  String username;
  String email;
  String password;


  factory SignupPost.fromRawJson(String str) =>
      SignupPost.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignupPost.fromJson(Map<String, dynamic> json) => SignupPost(
    username: json["username"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "password": password,
  };
}