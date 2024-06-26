import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  final String appVersion = '1.0.0';
  final String appDescription = 
  'This program has been created in cooperation with the Afghanistan Chess Federation and Kabul University to defend the monograph of Rahmatullah Ahmadi and Murtaza Yosufi.';
  final String developerName = 'Rahmatullah Ahmadian \n Murtaza Yosufi';
  final String developerCompany = 'Kabul University';
  final String contactEmail = 'rahmatullahahmadion9@gmail.com';

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const  Center(
              child: Hero(
                tag: 'app-logo',
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/logo.png'), // Your app logo
                ),
              ),
            ),
           const SizedBox(height: 16),
           const Center(
              child: Text(
                'Afghanuistan chess',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                'Version $appVersion',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
           const SizedBox(height: 24),
           const Text(
              'About My App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              appDescription,
              style:const TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
           const Text(
              'Developed by:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '$developerName\n$developerCompany\nContact: $contactEmail',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Follow us on:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.web),
                  onPressed: () => _launchURL('https://yourwebsite.com'),
                ),
                IconButton(
                  icon: Icon(Icons.facebook),
                  onPressed: () => _launchURL('https://facebook.com/yourpage'),
                ),
                IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () => _launchURL('https://twitter.com/yourhandle'),
                ),
                IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () => _launchURL('https://linkedin.com/in/yourprofile'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
