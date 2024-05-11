import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:aplikasi_budaya/view/editProfile.dart';
import 'package:aplikasi_budaya/view/home.dart';
import 'package:http/http.dart' as http;
import 'package:aplikasi_budaya/model/ModelUser.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_budaya/model/ModelUser.dart';

class ProfilePage extends StatelessWidget {
  final ModelUsers currentUser;

  ProfilePage({required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAD7C8),
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color.fromARGB(245, 221, 99, 95),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Personal Information',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Text('Username'),
                  subtitle: Text(currentUser.username),
                ),
                ListTile(
                  title: Text('Email'),
                  subtitle: Text(currentUser.email),
                ),
                ListTile(
                  title: Text('Name'),
                  subtitle: Text(currentUser.name),
                ),
                ListTile(
                  title: Text('Phone'),
                  subtitle: Text(currentUser.phone),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage(
                    currentUser: currentUser,
                  )),
                );
              },
              child: Text('Edit Profile',
               style: TextStyle(
                        color: Color.fromARGB(245, 221, 99, 95),
                      ),
                    ),   
            ),
          ),
        ],
      ),
    );
  }
}
