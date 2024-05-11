import 'package:flutter/material.dart';
import 'package:aplikasi_budaya/view/detailSejarawan.dart';
import 'package:aplikasi_budaya/view/home.dart';
import 'package:aplikasi_budaya/view/list_sejarawan.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../model/ModelAddSejarawan.dart';
import 'login.dart';

class CreateSejarawan extends StatefulWidget {
  const CreateSejarawan({Key? key}) : super(key: key);

  @override
  State<CreateSejarawan> createState() => _CreateSejarawanState();
}

class _CreateSejarawanState extends State<CreateSejarawan> {
  TextEditingController _namaController = TextEditingController();
  String _fotoPath = ''; // Ubah ke tipe String
  TextEditingController _asalController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();
  String _jenisKelaminValue = '';
  DateTime _selectedDate = DateTime.now();
  bool _obscurePassword = true;
  String? _nama;

  bool isLoading = false;

  Future<bool> requestPermissions() async {
    var status = await Permission.storage.request();
    return status.isGranted;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> selectFile() async {
    if (await requestPermissions()) {
      FilePickerResult? result =
      await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.single.path != null) {
        setState(() {
          _fotoPath = result.files.single.path!;
        });
      } else {
        print("No file selected");
      }
    } else {
      print("Storage permission not granted");
    }
  }

  Future<void> createSejarawan() async {
    if (_namaController.text.isEmpty ||
        _asalController.text.isEmpty ||
        _jenisKelaminValue.isEmpty ||
        _deskripsiController.text.isEmpty ||
        _fotoPath.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Semua field harus diisi')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      Uri uri =
      Uri.parse('http://192.168.1.9/budaya_server/postTokoh.php');

      http.MultipartRequest request = http.MultipartRequest('POST', uri)
        ..fields['nama'] = _namaController.text
        ..fields['tgl_lahir'] = _selectedDate.toString()
        ..fields['asal'] = _asalController.text
        ..fields['jenis_kelamin'] = _jenisKelaminValue
        ..fields['deskripsi'] = _deskripsiController.text;

      if (_fotoPath.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'foto',
            _fotoPath,
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      print(
          "Server response: $responseBody"); // This line will print the response body

      if (response.statusCode == 200) {
        try {
          ModelAddSejarawan data = modelAddSejarawaFromJson(responseBody);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${data.message}')),
          );
          if (data.isSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SejarawanPage()),
                  (route) => false,
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to parse response: $e')),
          );
        }
      } else {
        throw Exception(
            'Failed to upload data, status code: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFAD7C8),
        title: Row(
          children: [
            Text(
              'Add Sejarawan',
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFFAD7C8),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Nama',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
              controller: _namaController,
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: selectFile,
              child: InputDecorator(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Pilih Foto",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      SizedBox(width: 10),
                      Text(_fotoPath.isNotEmpty
                          ? _fotoPath
                          .split('/')
                          .last
                          : 'Pilih foto'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () => _selectDate(context), // Date picker call
              child: InputDecorator(
                decoration: InputDecoration(
                  hintText: 'Tanggal Lahir',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(DateFormat('yyyy-MM-dd').format(_selectedDate)),
                    Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Asal",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
              controller: _asalController,
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: 'Jenis Kelamin',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
              value: _jenisKelaminValue.isNotEmpty ? _jenisKelaminValue : null,
              onChanged: (String? newValue) {
                setState(() {
                  _jenisKelaminValue = newValue!;
                });
              },
              items: <String>['', 'Laki Laki', 'Perempuan']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _deskripsiController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Deskripsi',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () {
                CreateSejarawan();
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFFFAD7C8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Save ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ElevatedButton(
            //   onPressed: addSejarawan,
            //   child: Container(
            //     height: 60,
            //     decoration: BoxDecoration(
            //       color: Color(0xFF008080),
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //     child: Stack(
            //       alignment: Alignment.center,
            //       children: <Widget>[
            //         Align(
            //           alignment: Alignment.center,
            //           child: Text(
            //             'Edit ',
            //             textAlign: TextAlign.center,
            //             style: TextStyle(
            //               fontSize: 18,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.white,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//       body: SingleChildScrollView(
//     padding: EdgeInsets.all(16.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Container(
//               padding: EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.white,
//               ),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context, HomeScreen());
//                 },
//                 child: Image.asset(
//                   'images/back.png',
//                   width: 20,
//                   height: 20,
//                 ),
//               ),
//             ),
//             SizedBox(width: 10),
//             Text(
//               'Create Sejarawan',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Rubik',
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//         // SizedBox(height: 50),
//         // Image.asset(
//         //   'images/gambar5.png',
//         //   width: 150, // Ubah lebar gambar menjadi lebih kecil
//         // ),
//         SizedBox(height: 20),
//         Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: 15,
//               ),
//               Container(
//                 width: 450,
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     fillColor: Colors.grey.withOpacity(0.2),
//                     filled: true,
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     hintText: 'Nama',
//                     suffixIcon: _name != null && _name!.isNotEmpty
//                         ? Icon(Icons.check, color: Colors.green)
//                         : null,
//                   ),
//                   controller: _namaController,
//                   onChanged: (value) {
//                     setState(() {
//                       _name = value.trim();
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Nama tidak boleh kosong';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 width: 450,
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     fillColor: Colors.grey.withOpacity(0.2),
//                     filled: true,
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     hintText: 'Foto',
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               InkWell(
//                 onTap: selectFile,
//                 child: InputDecorator(
//                   decoration: InputDecoration(
//                     labelText: 'Foto',
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                       borderSide: BorderSide.none,
//                     ),
//                     contentPadding:
//                         EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                   ),
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: [
//                         Icon(Icons.image),
//                         SizedBox(width: 10),
//                         Text(_fotoPath.isNotEmpty
//                             ? _fotoPath.split('/').last
//                             : 'Pilih foto'),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () => _selectDate(context),
//                 // Date picker call
//                 child: InputDecorator(
//                   decoration: InputDecoration(
//                     labelText: 'Tanggal Lahir',
//                     filled: true,
//                     fillColor: Colors.white,
//                     prefixIcon: Icon(Icons.calendar_today),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                       borderSide: BorderSide.none,
//                     ),
//                     contentPadding:
//                         EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Text(DateFormat('yyyy-MM-dd').format(_selectedDate)),
//                       Icon(Icons.calendar_today),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 width: 450,
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     fillColor: Colors.grey.withOpacity(0.2),
//                     filled: true,
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     hintText: 'Asal',
//                     suffixIcon: _name != null && _name!.isNotEmpty
//                         ? Icon(Icons.check, color: Colors.green)
//                         : null,
//                   ),
//                   controller: _asalController,
//                   onChanged: (value) {
//                     setState(() {
//                       _name = value.trim();
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Asal tidak boleh kosong';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               DropdownButtonFormField<String>(
//                 decoration: InputDecoration(
//                   labelText: 'Jenis Kelamin',
//                   filled: true,
//                   fillColor: Colors.white,
//                   prefixIcon: Icon(Icons.person_outline),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide.none,
//                   ),
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                 ),
//                 value:
//                     _jenisKelaminValue.isNotEmpty ? _jenisKelaminValue : null,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     _jenisKelaminValue = newValue!;
//                   });
//                 },
//                 items: <String>['', 'Laki Laki', 'Perempuan']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 width: 450,
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     fillColor: Colors.grey.withOpacity(0.2),
//                     filled: true,
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     hintText: 'Deskripsi',
//                     suffixIcon: _name != null && _name!.isNotEmpty
//                         ? Icon(Icons.check, color: Colors.green)
//                         : null,
//                   ),
//                   controller: _deskripsiController,
//                   onChanged: (value) {
//                     setState(() {
//                       _name = value.trim();
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Tanggal tidak boleh kosong';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               SizedBox(height: 20),
//               Container(
//                 width: MediaQuery.of(context).size.width - (2 * 98),
//                 height: 55,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     elevation: 7,
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => SejarawanPage1(),
//                       ),
//                     );
//                   },
//                   child: Text(
//                     'Save',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   ));
// }
}
