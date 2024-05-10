import 'package:flutter/material.dart';
import 'package:aplikasi_budaya/model/ModelBudaya.dart';

class DetailGaleriPage extends StatefulWidget {
  final Datum? data;

  const DetailGaleriPage({Key? key, this.data}) : super(key: key);

  @override
  State<DetailGaleriPage> createState() => _DetailGaleriPageState();
}

class _DetailGaleriPageState extends State<DetailGaleriPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Detail Galeri'),
        backgroundColor: Color.fromARGB(245, 221, 99, 95),
      ),
      body: Center(
        child: widget.data != null && widget.data!.image.isNotEmpty
            ? Image.network(
          'http://192.168.1.9/budaya_server/budaya/${widget.data!.image}',
          fit: BoxFit.contain,
        )
            : Container(), // Widget kosong jika data tidak tersedia atau gambar tidak ada
      ),
    );
  }
}
