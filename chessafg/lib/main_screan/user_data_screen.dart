import 'package:chessafg/main_screan/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:chessafg/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('User Data'),
        ),
        body: Center(
          child: Text('No user logged in.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('User Data'),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: FirestoreService().getUserData(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error fetching user data.'));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No user data found.'));
          }

          final userData = snapshot.data!;
          final String name = userData['name'] ?? 'Unknown';
          final String email = userData['email'] ?? 'Unknown';
          final String profilePictureUrl = userData['profilePictureUrl'] ?? 'https://via.placeholder.com/150';
          final int rating = userData['rating'] ?? 0;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(profilePictureUrl),
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
