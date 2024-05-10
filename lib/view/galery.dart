import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aplikasi_budaya/view/detail_galery.dart';
import 'package:aplikasi_budaya/model/ModelBudaya.dart';

class GaleriPage extends StatefulWidget {
  const GaleriPage({super.key});

  @override
  State<GaleriPage> createState() => _GaleriPageState();
}

class _GaleriPageState extends State<GaleriPage> {
  late List<Datum> _budayaList;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _fetchBudaya();
  }

  Future<void> _fetchBudaya() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.9/budaya_server/list_budaya.php'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      setState(() {
        _budayaList =
            List<Datum>.from(parsed['data'].map((x) => Datum.fromJson(x)));
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load budaya');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAD7C8),
      appBar: AppBar(
        title: Text('Galeri'),
        backgroundColor: Color.fromARGB(245, 221, 99, 95),
      ),
      body: GridView.builder(
          itemCount: _budayaList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index){
            final galeri = _budayaList[index];
            return GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailGaleriPage(data: galeri),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(3.0),
                child: GridTile(
                   child: Image.network('http://192.168.1.9/budaya_server/budaya/${galeri.image}'),
                ),
              ),
            );
          }),
    );
  }
}
