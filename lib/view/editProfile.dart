import 'package:flutter/material.dart';
import 'package:aplikasi_budaya/model/ModelUser.dart'; // Import model user sesuai kebutuhan

class EditProfilePage extends StatefulWidget {
  final ModelUsers currentUser; // Gunakan model user sesuai kebutuhan

  EditProfilePage({required this.currentUser});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Mengisi nilai teks controller dengan nilai dari currentUser
    _usernameController.text = widget.currentUser.username;
    _emailController.text = widget.currentUser.email;
    _nameController.text = widget.currentUser.name;
    _phoneController.text = widget.currentUser.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Color.fromARGB(245, 221, 99, 95),
      ),
      backgroundColor: const Color(0xFFFAD7C8),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Save',
               style: TextStyle(
                        color: Color.fromARGB(245, 221, 99, 95),
                      ),
                    ),       
            ),
          ],
        ),
      ),
    );
  }
}
