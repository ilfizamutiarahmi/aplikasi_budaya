import 'dart:convert';

ModelSejarawan modelSejarawanFromJson(String str) =>
    ModelSejarawan.fromJson(json.decode(str));

String modelSejarawanToJson(ModelSejarawan data) => json.encode(data.toJson());

class ModelSejarawan {
  bool is_susccess;
  String message;
  List<Datum> data;

  ModelSejarawan({
    required this.is_susccess,
    required this.message,
    required this.data,
  });

  factory ModelSejarawan.fromJson(Map<String, dynamic> json) {
    return ModelSejarawan(
      is_susccess: json['is_susccess'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'is_susccess': is_susccess,
        'message': message,
        'data': data.map((datum) => datum.toJson()).toList(),
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

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json['id'] ?? '0',
      nama: json['nama'] ?? 'No nama',
      asal: json['asal'] ?? 'No asal',
      foto: json['foto'] ?? 'default_foto.png',
      tgl_lahir: json['tgl_lahir'] ?? 'No Tanggal lahir',
      jenis_kelamin: json['jenis_kelamin'] ?? 'No jenis kelamin',
      deskripsi: json['deskripsi'] ?? 'No deskripsi',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'asal': asal,
        'foto': foto,
        'tgl_lahir': tgl_lahir,
        'jenis_kelamin': jenis_kelamin,
        'deskripsi': deskripsi,
      };
}
