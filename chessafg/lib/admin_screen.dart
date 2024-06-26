import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  File? _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String?> uploadImage(File image) async {
    try {
      String fileName = 'news_images/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
      Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = storageReference.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print('Image uploaded successfully. URL: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      print('Failed to upload image: $e');
      return null;
    }
  }

  void _postNews() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty || _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields and select an image.')));
      return;
    }

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User is not authenticated.')));
      return;
    }

    try {
      String? imageUrl = await uploadImage(_image!);
      if (imageUrl != null) {
        await FirebaseFirestore.instance.collection('news').add({
          'title': _titleController.text,
          'content': _contentController.text,
          'imageUrl': imageUrl,
          'timestamp': Timestamp.now(),
        });

        _titleController.clear();
        _contentController.clear();
        setState(() {
          _image = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('News posted successfully!')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to get image URL.')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to post news: $e')));
      print('Failed to post news: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin - Post News'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: getImage,
              icon: Icon(Icons.image),
              label: Text('Select Image'),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _postNews,
              icon: Icon(Icons.send),
              label: Text('Post News'),
            ),
          ],
        ),
      ),
    );
  }
}
