import 'package:flutter/material.dart';
import 'package:aplikasi_budaya/model/ModelSejarawan.dart';
import 'package:intl/intl.dart';

class DetailSejarawan extends StatelessWidget {
  final Datum? data;
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

   DetailSejarawan({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    // Mengonversi string tanggal lahir ke objek DateTime
    final DateTime? birthDate = DateTime.tryParse(data?.tgl_lahir ?? '');

    // Mengonversi objek DateTime ke string dengan format yang diinginkan
    final String formattedBirthDate =
        birthDate != null ? formatter.format(birthDate) : '';

    return Scaffold(
      backgroundColor: const Color(0xFFFAD7C8),
      appBar: AppBar(
        title: Text('Detail Sejarawan'),
        backgroundColor: const Color(0xFFFAD7C8),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Center(
                  child: data != null && data!.foto.isNotEmpty
                      ? Image.network(
                          'http://192.168.1.9/budaya_server/tokoh/${data!.foto}',
                          fit: BoxFit.fill,
                        )
                      : Container(),
                ),
              ),
              SizedBox(height: 16),
              Text(
                data?.nama ?? ' - ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                data?.asal ?? ' - ',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                formattedBirthDate, // Menggunakan tanggal lahir yang diformat
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                data?.jenis_kelamin ?? ' - ',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Deskripsi :',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                data?.deskripsi ?? ' - ',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
