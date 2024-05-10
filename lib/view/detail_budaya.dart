import 'package:flutter/material.dart';
import 'package:aplikasi_budaya/model/ModelBudaya.dart';

class DetailBudaya extends StatelessWidget {
  final Datum? data;

  const DetailBudaya({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAD7C8),
      appBar: AppBar(
        title: Text('Detail Budaya'),
        backgroundColor: const Color(0xFFFAD7C8),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: data != null && data!.image.isNotEmpty
                        ? Image.network(
                            'http://192.168.1.9/budaya_server/budaya/${data!.image}',
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: 200,
                          )
                        : Container(),
                  ),
                  SizedBox(height: 16),
                  Text(
                    data?.title ?? 'No Title',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    data?.content ?? 'No Content',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
