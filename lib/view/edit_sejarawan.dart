import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:aplikasi_budaya/view/list_sejarawan.dart';

import '../model/ModelSejarawan.dart';


class EditSejarawanPage extends StatefulWidget {
  final String id;
  final String nama;
  final String tgl_lahir;
  final String asal;
  final String jenis_kelamin;
  final String deskripsi;

  const EditSejarawanPage({
    Key? key,
    required this.id,
    required this.nama,
    required this.tgl_lahir,
    required this.asal,
    required this.jenis_kelamin,
    required this.deskripsi,
  }) : super(key: key);
  
  get sejarawan => null;

  @override
  _EditSejarawanPageState createState() => _EditSejarawanPageState();
}

class _EditSejarawanPageState extends State<EditSejarawanPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tglLahirController = TextEditingController();
  String _fotoPath = '';
  final TextEditingController _asalController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  String _jenisKelaminValue = '';
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

void _initializeFields() {
  _namaController.text = widget.nama;
  _fotoPath = ''; // Atur ke nilai default jika diperlukan
  _asalController.text = widget.asal;
  _deskripsiController.text = widget.deskripsi;
  _jenisKelaminValue = widget.jenis_kelamin;
  _selectedDate = DateTime.parse(widget.tgl_lahir);
}

  Future<void> _selectFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _fotoPath = result.files.single.path!;
      });
    }
  }

  Future<void> _saveChanges() async {
    final newNama = _namaController.text;
    final newAsal = _asalController.text;
    final newDeskripsi = _deskripsiController.text;

    if (newNama.isEmpty || newAsal.isEmpty || newDeskripsi.isEmpty || _jenisKelaminValue.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All fields are required')));
      return;
    }

    final uri = Uri.parse('http://192.168.1.9/budaya_server/updateTokoh.php');
    final request = http.MultipartRequest('POST', uri)
      ..fields['id'] = widget.id
      ..fields['nama'] = newNama
      ..fields['asal'] = newAsal
      ..fields['deskripsi'] = newDeskripsi
      ..fields['jenis_kelamin'] = _jenisKelaminValue
      ..fields['tanggal_lahir'] = _selectedDate.toIso8601String();

    if (_fotoPath.isNotEmpty && _fotoPath != widget.sejarawan.data.first.foto) {
      request.files.add(await http.MultipartFile.fromPath('foto', _fotoPath, contentType: MediaType('image', 'jpeg')));
    }

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody);
        print("Response Body: $responseBody");

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['message'])));

        final isSuccess = data['is_success'] ?? false;
        if (isSuccess) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SejarawanPage()));
        }
      } else {
        throw Exception('Failed to update data, status code: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFAD7C8),
        title: Text(
          'Edit Sejarawan',
          style: TextStyle(fontSize: 18.0, fontFamily: 'Jost', fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Color(0xFFFAD7C8),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                ),
              ),
              TextFormField(
                controller: _tglLahirController,
                decoration: InputDecoration(
                  labelText: 'Tanggal Lahir',
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    _tglLahirController.text = pickedDate.toString();
                  }
                },
              ),
              TextFormField(
                controller: _asalController,
                decoration: InputDecoration(
                  labelText: 'Asal',
                ),
              ),
              DropdownButtonFormField<String>(
                value: _jenisKelaminValue.isNotEmpty ? _jenisKelaminValue : null,
                onChanged: (String? newValue) {
                  setState(() {
                    _jenisKelaminValue = newValue!;
                  });
                },
                items: <String>['', 'Laki-laki', 'Perempuan'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Jenis Kelamin',
                ),
              ),

              TextFormField(
                controller: _deskripsiController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                ),
              ),
              TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Foto',
                ),
              ),
              // ElevatedButton(
              //   onPressed: _getImage,
              //   child: Text('Pilih Foto'),
              // ),
              // SizedBox(height: 20),
              // _fotoPath != null
              //     ? Image.file(_fotoPath!, width: 100, height: 100)
              //     : SizedBox(),

              // SizedBox(height: 20),
            SizedBox(height: 16),
            InkWell(
              onTap: _saveChanges,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Color.fromARGB(245, 221, 99, 95),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    'Update',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
