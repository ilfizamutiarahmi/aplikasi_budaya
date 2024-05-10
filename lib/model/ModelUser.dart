import 'dart:convert';

List<ModelUsers> modelUsersFromJson(String str) => List<ModelUsers>.from(json.decode(str).map((x) => ModelUsers.fromJson(x)));

String modelUsersToJson(List<ModelUsers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelUsers {
  int id;
  String username;
  String email;
  String name;
  String phone;

  ModelUsers({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.phone,

  });

  factory ModelUsers.fromJson(Map<String, dynamic> json) => ModelUsers(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    name: json["name"],
    phone: json["phone"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "name": name,
    "phone": phone,
  };
}