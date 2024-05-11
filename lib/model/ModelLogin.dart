import 'dart:convert';

ModelLogin modelLoginFromJson(String str) => ModelLogin.fromJson(json.decode(str));

String modelLoginToJson(ModelLogin data) => json.encode(data.toJson());

class ModelLogin {
  bool success;
  int status;
  String message;
  Data data;

  ModelLogin({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
    success: json["success"] ?? false,
    status: json["status"] ?? 0,
    message: json["message"] ?? "",
    data: json["data"] != null ? Data.fromJson(json["data"]) : Data(),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String id;
  String username;
  String email;
  String name;
  String phone;

  Data({
    this.id = "",
    this.username = "",
    this.email = "",
    this.name = "",
    this.phone = "",
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] ?? "",
    username: json["username"] ?? "",
    email: json["email"] ?? "",
    name: json["name"] ?? "",
    phone: json["phone"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "name": name,
    "phone": phone,
  };
}
