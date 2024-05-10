import 'dart:convert';

ModelSejarawan modelSejarawanFromJson(String str) =>
    ModelSejarawan.fromJson(json.decode(str));

String modelSejarawanToJson(ModelSejarawan data) => json.encode(data.toJson());

class ModelSejarawan {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelSejarawan({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelSejarawan.fromJson(Map<String, dynamic> json) => ModelSejarawan(
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
  String nama;
  String asal;
  String foto;
  String tgl_lahir;
  String jenis_kelamin;
  String deskripsi;

  Datum({
    required this.id,
    required this.nama,
    required this.asal,
    required this.foto,
    required this.tgl_lahir,
    required this.jenis_kelamin,
    required this.deskripsi,

  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? '0',
        nama: json["nama"] ?? 'No nama',
        asal:
            json["asal"] ?? 'No asal',
        foto: json["foto"] ??
            'default_foto.png',
        tgl_lahir: json["tgl_lahir"] ?? 'No Tanggal lahir',
        jenis_kelamin: json["jenis_kelamin"] ?? 'No jenis kelamin',
        deskripsi: json["deskripsi"] ?? 'No deskripsi',


      );

  get content => null;

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "asal": asal,
        "foto": foto,
        "tgl_lahir": tgl_lahir,
        "jenis_kelamin": jenis_kelamin,
        "deskripsi": deskripsi
      };
}