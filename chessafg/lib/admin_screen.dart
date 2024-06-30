import 'package:chessafg/provider/infomation/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

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
     final themeProvider = Provider.of<ThemeProvider>(context);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print(themeProvider.language == 'English'
              ? 'No image selected.'
              : themeProvider.language == 'فارسی'
                  ? 'هیچ تصویری انتخاب نشده است.'
                  : themeProvider.language == 'پشتو'
                  ? 'هیڅ انځور نه دی ټاکل شوی.'
                  : themeProvider.language == 'German'
                      ? 'Kein Bild ausgewählt.'
                      : 'No image selected.', );
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    if (_titleController.text.isEmpty || _contentController.text.isEmpty || _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text( themeProvider.language == 'English'
              ? 'Please fill all fields and select an image.'
              : themeProvider.language == 'فارسی'
                  ? 'لطفا تمام فیلدها را پر کنید و یک تصویر را انتخاب کنید.'
                  : themeProvider.language == 'پشتو'
                  ? 'مهرباني وکړئ ټولې ساحې ډکې کړئ او یو انځور غوره کړئ.'
                  : themeProvider.language == 'German'
                      ? 'Bitte füllen Sie alle Felder aus und wählen Sie ein Bild aus.'
                      : 'Please fill all fields and select an image.',)));
      return;
    }

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(themeProvider.language == 'English'
              ? 'User is not authenticated.'
              : themeProvider.language == 'فارسی'
                  ? 'کاربر احراز هویت نشده است.'
                  : themeProvider.language == 'پشتو'
                  ? 'کارن تصدیق شوی نه دی.'
                  : themeProvider.language == 'German'
                      ? 'Der Benutzer ist nicht authentifiziert.'
                      : 'User is not authenticated.',)));
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

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
          themeProvider.language == 'English'
              ? 'News posted successfully!'
              : themeProvider.language == 'فارسی'
                  ? 'خبر با موفقیت ارسال شد!'
                  : themeProvider.language == 'پشتو'
                  ? 'خبر په بریالیتوب سره خپور شو!'
                  : themeProvider.language == 'German'
                      ? 'Neuigkeiten erfolgreich gepostet!'
                      : 'News posted successfully!',
          )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
          themeProvider.language == 'English'
              ? 'Failed to get image URL.'
              : themeProvider.language == 'فارسی'
                  ? 'پیوند تصویر دریافت نشد.'
                  : themeProvider.language == 'پشتو'
                  ? 'د انځور URL ترلاسه کولو کې پاتې راغلی.'
                  : themeProvider.language == 'German'
                      ? 'Bild-URL konnte nicht abgerufen werden.'
                      : 'Failed to get image URL.',
          )));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
        themeProvider.language == 'English'
              ? 'Failed to post news: $e'
              : themeProvider.language == 'فارسی'
                  ? 'ارسال خبر ناموفق بود: $e'
                  : themeProvider.language == 'پشتو'
                  ? 'د خبرونو په خپرولو کې پاتې راغلی: $e'
                  : themeProvider.language == 'German'
                      ? 'Nachrichten konnten nicht gepostet werden: $e'
                      : 'Failed to post news: $e',)));
      print(themeProvider.language == 'English'
              ? 'Failed to post news: $e'
              : themeProvider.language == 'فارسی'
                  ? 'ارسال خبر ناموفق بود: $e'
                  : themeProvider.language == 'پشتو'
                  ? 'د خبرونو په خپرولو کې پاتې راغلی: $e'
                  : themeProvider.language == 'German'
                      ? 'Nachrichten konnten nicht gepostet werden: $e'
                      : 'Failed to post news: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
         themeProvider.language == 'English'
              ? 'Admin - Post News'
              : themeProvider.language == 'فارسی'
                  ? 'مدیر - نشر خبر'
                  : themeProvider.language == 'پشتو'
                  ? 'مدیر - خپرول خبرونه'
                  : themeProvider.language == 'German'
                      ? 'Admin - Neuigkeiten veröffentlichen'
                      : 'Admin - Post News', 
          ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: themeProvider.language == 'English'
              ? 'Titel'
              : themeProvider.language == 'فارسی'
                  ? 'عنوان'
                  : themeProvider.language == 'پشتو'
                  ? 'عنوان'
                  : themeProvider.language == 'German'
                      ? 'Titel'
                      : 'Titel',
              
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText:themeProvider.language == 'English'
              ? 'Content'
              : themeProvider.language == 'فارسی'
                  ? 'محتوا'
                  : themeProvider.language == 'پشتو'
                  ? 'منځپانګه'
                  : themeProvider.language == 'German'
                      ? 'Inhalt'
                      : 'Content', 
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            _image == null
                ? Text( themeProvider.language == 'English'
              ? 'No image selected.'
              : themeProvider.language == 'فارسی'
                  ? 'هیچ تصویری انتخاب نشده است.'
                  : themeProvider.language == 'پشتو'
                  ? 'هیڅ عکس نه دی ټاکل شوی.'
                  : themeProvider.language == 'German'
                      ? 'Kein Bild ausgewählt.'
                      : 'No image selected.',
                  )
                : Image.file(_image!),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: getImage,
              icon: Icon(Icons.image),

              label: Text( themeProvider.language == 'English'
              ? 'Select Image'
              : themeProvider.language == 'فارسی'
                  ? 'تصویر را انتخاب کنید'
                  : themeProvider.language == 'پشتو'
                  ? 'انځور غوره کړئ'
                  : themeProvider.language == 'German'
                      ? 'Bild auswählen'
                      : 'Select Image',
                ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _postNews,
              icon: Icon(Icons.send),
              label: Text( themeProvider.language == 'English'
              ? ' Post News'
              : themeProvider.language == 'فارسی'
                  ? ' نشر خبر'
                  : themeProvider.language == 'پشتو'
                  ? ' خپرول خبرونه'
                  : themeProvider.language == 'German'
                      ? ' Neuigkeiten veröffentlichen'
                      : 'Post News', 
               
                ),
            ),
          ],
        ),
      ),
    );
  }
}
