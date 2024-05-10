import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplikasi_budaya/model/ModelSejarawan.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_budaya/view/login.dart';
import 'package:aplikasi_budaya/model/sessionManager.dart';
import 'package:aplikasi_budaya/view/detail_budaya.dart';
import 'package:aplikasi_budaya/view/galery.dart';
import 'package:aplikasi_budaya/view/home.dart';
import 'package:aplikasi_budaya/view/detailSejarawan.dart';


import 'register.dart';

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

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _fetchSejarawan();
    _filteredSejarawanList = [];
  }

  Future<void> _fetchSejarawan() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.9/budaya_server/getTokoh.php'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      setState(() {
        _sejarawanList =
            List<Datum>.from(parsed['data'].map((x) => Datum.fromJson(x)));
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
          .where((sejarawan) =>
              sejarawan.nama.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
                                          sejarawan.tgl_lahir,
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(height: 5),
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
              if(_currentIndex == 0){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
              }
              else if(_currentIndex == 1){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SejarawanPage()));
              }
              else if(_currentIndex == 2){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>GaleriPage()));
              }
              else if(_currentIndex == 3){
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

