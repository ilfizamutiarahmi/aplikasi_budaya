import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplikasi_budaya/model/ModelBudaya.dart';
import 'package:aplikasi_budaya/model/ModelUser.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_budaya/view/login.dart';
import 'package:aplikasi_budaya/util/sessionManager.dart';
import 'package:aplikasi_budaya/view/detail_budaya.dart';
import 'package:aplikasi_budaya/view/galery.dart';
import 'package:aplikasi_budaya/view/list_sejarawan.dart';
import 'package:aplikasi_budaya/view/profile.dart';

import 'register.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  int _currentIndex = 0;
  late ModelUsers currentUser = ModelUsers(
    id: 0, // Atau nilai yang sesuai
    username: '',
    email: '',
    name: '',
    phone: '',
  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }

  String? username;

  Future<void> getDataSession() async {
    bool hasSession = await sessionManager.getSession();
    if (hasSession) {
      setState(() {
        username = sessionManager.username;
        print('Data session: $username');
      });
    } else {
      print('Session tidak ditemukan!');
    }
  }

// Inisialisasi awal _budayaList
  late List<Datum> _budayaList = [];
  late List<Datum> _filteredBudayaList;
  late bool _isLoading;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getDataSession();
    _isLoading = true;
    _fetchBudaya();
    _filteredBudayaList = [];
  }
  Future<void> _fetchBudaya() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.9/budaya_server/list_budaya.php'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      setState(() {
        _budayaList =
            List<Datum>.from(parsed['data'].map((x) => Datum.fromJson(x)));
        _filteredBudayaList = _budayaList;
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load budaya');
    }
  }

  void _filterBudayaList(String query) {
    setState(() {
      _filteredBudayaList = _budayaList
          .where((budaya) =>
              budaya.content.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAD7C8),
      appBar: AppBar(
        title: Text(
          'Hallo', 
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xFFFAD7C8),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Logout',
            color: Colors.black,
            onPressed: () {
              setState(() {
                sessionManager.clearSession();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              });
            },
          ),
        ],
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
                  onChanged: _filterBudayaList,
                  decoration: const InputDecoration(
                    labelText: 'Search Budaya',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  :ListView.builder(
                  shrinkWrap: true,
                  itemCount: _filteredBudayaList.length,
                  itemBuilder: (context, index) {
                    final budaya = _filteredBudayaList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailBudaya(data: budaya),
                          ),
                        );
                      },
                      child: Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                'http://192.168.1.9/budaya_server/budaya/${budaya.image}',
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: 200,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(budaya.title),
                            subtitle: Text(
                              budaya.content,
                              maxLines: 2,
                            ),
                          ),
                        ],
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
          // Handler untuk indeks 0 (Home)
        }
        else if(_currentIndex == 1){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SejarawanPage()));

        }
        else if(_currentIndex == 2){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>GaleriPage()));
        }
        else if(_currentIndex == 3){
          if (currentUser != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(currentUser: currentUser),
              ),
            );
          } else {
            // Tangani skenario ketika currentUser tidak valid
            print('Log Data pengguna tidak tersedia!');
          }
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
