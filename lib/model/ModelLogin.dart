import 'dart:convert';

ModelLogin modelLoginFromJson(String str) => ModelLogin.fromJson(json.decode(str));

String modelLoginToJson(ModelLogin data) => json.encode(data.toJson());

class ModelLogin {
  bool sukses;
  int status;
  String pesan;
  Data data;

  ModelLogin({
    required this.sukses,
    required this.status,
    required this.pesan,
    required this.data,
  });

 factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
  sukses: json["sukses"] ?? false,
  status: json["status"] ?? 0,
  pesan: json["pesan"] ?? "",
  data: json["data"] != null ? Data.fromJson(json["data"]) : Data(
    id: "",
    username: "",
    email: "",
    password: "",
    name: "",
    phone: "",
  ),
);

  Map<String, dynamic> toJson() => {
    "sukses": sukses,
    "status": status,
    "pesan": pesan,
    "data": data.toJson(),
  };
}

class Data {
  String id;
  String username;
  String email;
  String password;
  String name;
  String phone;

  Data({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.name,
    required this.phone, 
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] ?? "",
    username: json["username"] ?? "",
    email: json["email"] ?? "",
    password: json["password"] ?? "",
    name: json["name"] ?? "", 
    phone: json["phone"] ?? "", 
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "password": password,
    "name": name,
    "phone": phone,
  };
}