import 'dart:convert';

ModelRegister modelRegisterFromJson(String str) => ModelRegister.fromJson(json.decode(str));

String modelRegisterToJson(ModelRegister data) => json.encode(data.toJson());

class ModelRegister {
  int value;
  String username;
  String email;
  String name;
  String phone;
  String message;

  ModelRegister({
  required this.value,
  required this.username,
  required this.email,
  required this.name,
  required this.phone,
  required this.message,
  });


  factory ModelRegister.fromJson(Map<String, dynamic> json) => ModelRegister(
    value: json["value"],
    message: json["message"], username: 'json["username"]', email: 'json["email"]', name: 'json["name"]', phone: 'json["phone"]',
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
    "username": username,
    "email": email,
    "name": name,
    "phone": phone,
  };
}