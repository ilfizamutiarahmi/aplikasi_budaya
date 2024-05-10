import 'dart:convert';

ModelBudaya modelBudayaFromJson(String str) =>
    ModelBudaya.fromJson(json.decode(str));

String modelBudayaToJson(ModelBudaya data) => json.encode(data.toJson());

class ModelBudaya {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelBudaya({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelBudaya.fromJson(Map<String, dynamic> json) => ModelBudaya(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String title;
  String content;
  String image;

  Datum({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? '0',
        title: json["title"] ?? 'No Title',
        content:
            json["content"] ?? 'No Content',
        image: json["image"] ??
            'default_image.png',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "image": image,
      };
}