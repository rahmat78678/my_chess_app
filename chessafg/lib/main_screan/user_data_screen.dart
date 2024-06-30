import 'package:chessafg/main_screan/firestore_service.dart';
import 'package:chessafg/provider/game_provider.dart';
import 'package:chessafg/provider/infomation/ThemeProvider.dart';
import 'package:chessafg/service/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:chessafg/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameProvider = context.read<GameProvider>();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final themeProvider = Provider.of<ThemeProvider>(context);

    if (userId == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text(themeProvider.language == 'English'
              ? 'User Data'
              : themeProvider.language == 'فارسی'
                  ? 'مشخصات کاربر'
                  : themeProvider.language == 'پشتو'
                  ? 'د کارن پروفایل'
                  : themeProvider.language == 'German'
                      ? 'Benutzerdaten'
                      : 'User Data',),
        ),
        body: Center(
          child: Text(themeProvider.language == 'English'
              ? 'No user logged in.'
              : themeProvider.language == 'فارسی'
                  ? 'هیچ کاربری وارد نشده است'
                  : themeProvider.language == 'پشتو'
                  ? 'هیڅ کارن ننوتلی نه دی'
                  : themeProvider.language == 'German'
                      ? 'Kein Benutzer angemeldet'
                      : 'No user logged in.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(themeProvider.language == 'English'
              ? 'User Data'
              : themeProvider.language == 'فارسی'
                  ? 'مشخصات کاربر'
                  : themeProvider.language == 'پشتو'
                  ? 'د کارن پروفایل'
                  : themeProvider.language == 'German'
                      ? 'Benutzerdaten'
                      : 'User Data',),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: FirestoreService().getUserData(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(themeProvider.language == 'English'
              ? 'Error fetching user data.'
              : themeProvider.language == 'فارسی'
                  ? 'خطا در واکشی اطلاعات کاربر.'
                  : themeProvider.language == 'پشتو'
                  ? 'د کارن ډیټا په راوړلو کې تېروتنه.'
                  : themeProvider.language == 'German'
                      ? 'Fehler beim Abrufen der Benutzerdaten.'
                      : 'Error fetching user data.',));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text(themeProvider.language == 'English'
              ? 'No user data found.'
              : themeProvider.language == 'فارسی'
                  ? 'هیچ داده کاربری یافت نشد.'
                  : themeProvider.language == 'پشتو'
                  ? 'د کارونکي هیڅ معلومات ندي موندل شوي.'
                  : themeProvider.language == 'German'
                      ? 'Keine Benutzerdaten gefunden.'
                      : 'No user data found.', ));
          }

          final userData = snapshot.data!;
          final String name = userData['name'] ?? 'Unknown';
          final String email = userData['email'] ?? 'Unknown';
          final String profilePictureUrl = userData['profilePictureUrl'] ?? 'https://via.placeholder.com/150';
          final int rating = userData['playerRating'] ?? 0;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: gameProvider.userPhoto == ''
              ? CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(AssetsManager.userIcon),
                )
              : CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(gameProvider.userPhoto),
                ),
                  ),
                  SizedBox(height: 20),
                  Text('Name: $name', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Email: $email', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Rating: $rating', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  // Add more fields as needed
                  if (userData.containsKey('otherField1'))
                    Text('Other Field 1: ${userData['otherField1'] ?? 'N/A'}', style: TextStyle(fontSize: 18)),
                  if (userData.containsKey('otherField2'))
                    Text('Other Field 2: ${userData['otherField2'] ?? 'N/A'}', style: TextStyle(fontSize: 18)),
                  // Add more conditional fields based on your Firestore structure
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
