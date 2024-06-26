import 'dart:convert';
import 'package:aplikasi_budaya/model/ModelLogin.dart';
import 'package:http/http.dart' as http;
import 'package:aplikasi_budaya/model/ModelSejarawan.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_budaya/view/login.dart';
import 'package:aplikasi_budaya/util/sessionManager.dart';
import 'package:aplikasi_budaya/view/detail_budaya.dart';
import 'package:aplikasi_budaya/view/galery.dart';
import 'package:aplikasi_budaya/view/home.dart';
import 'package:aplikasi_budaya/view/detailSejarawan.dart';
import 'package:intl/intl.dart';
import 'package:aplikasi_budaya/view/create_sejarawan.dart';
import 'package:aplikasi_budaya/view/edit_sejarawan.dart';



class SejarawanPage extends StatefulWidget {
  @override
  _SejarawanPageState createState() => _SejarawanPageState();
}

class _SejarawanPageState extends State<SejarawanPage> {
  int _selectedIndex = 0;
  int _currentIndex = 0;

  late List<Datum> _sejarawanList;
  late List<Datum> _filteredSejarawanList;
  late bool _isLoading;
  TextEditingController _searchController = TextEditingController();
  
  // get mySejarawan => null;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _fetchSejarawan();
    _filteredSejarawanList = [];
  }

  Future<void> _fetchSejarawan() async {
    final response = await http.get(Uri.parse('http://192.168.1.9/budaya_server/getTokoh.php'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      setState(() {
        _sejarawanList = List<Datum>.from(parsed['data'].map((x) => Datum.fromJson(x)));
        _filteredSejarawanList = _sejarawanList;
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load Tokoh Sejarawan');
    }
  }

  void _filterSejarawanList(String query) {
    setState(() {
      _filteredSejarawanList = _sejarawanList
          .where((sejarawan) => sejarawan.nama.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

Future<void> _deleteSejarawan(String id) async {
  try {
    http.Response res = await http.post(
      Uri.parse('http://192.168.1.9/budaya_server/deleteTokoh.php'),
      body: {'id': id}, // Menggunakan id langsung tanpa konversi ke int
    );
    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data Sejarawan berhasil dihapus')),
      );
      _fetchSejarawan();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus Data Sejarawan')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.toString())),
    );
  }
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAD7C8),
      appBar: AppBar(
        title: Text(
          'Tokoh Sejarah',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xFFFAD7C8),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterSejarawanList,
                  decoration: const InputDecoration(
                    labelText: 'Search Tokoh Sejarah',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _filteredSejarawanList.length,
                      itemBuilder: (context, index) {
                        final sejarawan = _filteredSejarawanList[index];
                        final formatter = DateFormat('dd-MM-yyyy');
                        final birthDate = DateTime.tryParse(sejarawan.tgl_lahir) ?? DateTime.now();
                        final formattedBirthDate = formatter.format(birthDate);

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailSejarawan(data: sejarawan),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'http://192.168.1.9/budaya_server/tokoh/${sejarawan.foto}',
                                        fit: BoxFit.fill,
                                        width: 100,
                                        height: 120,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            sejarawan.nama,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            sejarawan.asal,
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            formattedBirthDate,
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                    MaterialPageRoute(builder: (context) => EditSejarawanPage(
                                                      id: sejarawan.id,
                                                      nama: sejarawan.nama,
                                                      tgl_lahir: sejarawan.tgl_lahir,
                                                      asal: sejarawan.asal,
                                                      jenis_kelamin: sejarawan.jenis_kelamin,
                                                      deskripsi: sejarawan.deskripsi,
                                                    )),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.grey,
                                              ),
                                            ),


                                              IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                          backgroundColor: Colors.white,
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            SizedBox(
                                                                height: 16),
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  'Delete',
                                                                  textAlign:TextAlign.center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:38,
                                                                    color: Colors.red,
                                                                    fontWeight:FontWeight.bold,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  'Are you sure want to delete data?',
                                                                  textAlign:TextAlign.center,
                                                                  style:TextStyle(
                                                                    fontSize: 16,
                                                                    color: Colors.black,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        actions: <Widget>[
                                                          Center(
                                                            child: TextButton(
                                                              onPressed: () {
                                                                Navigator.of(context).pop(); 
                                                              },
                                                              child: Text(
                                                                "Cancel",
                                                                style: TextStyle(
                                                                  color: Colors.red,
                                                                ),    
                                                                textAlign:TextAlign.center,
                                                              ),
                                                            ),
                                                          ),
                                                          Center(
                                                            child: TextButton(
                                                              onPressed: () {
                                                                _deleteSejarawan(sejarawan.id);
                                                              },
                                                              child: Text(
                                                                "Ok",
                                                                style: TextStyle(
                                                                  color: Colors.green,
                                                                ),
                                                                textAlign:TextAlign.center,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateSejarawan()));
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(245, 221, 99, 95), // Warna latar belakang tombol tambah
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color.fromARGB(245, 221, 99, 95), // Menetapkan warna latar belakang
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Menetapkan jenis BottomNavigationBar
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
              if (_currentIndex == 0) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
              } else if (_currentIndex == 1) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SejarawanPage()));
              } else if (_currentIndex == 2) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => GaleriPage()));
              } else if (_currentIndex == 3) {
                // _goToUserProfile(); // Handler untuk indeks 3 (Profile)
              }
            });
          },
          selectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt),
              label: 'Sejarawan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.image),
              label: 'Galery',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
