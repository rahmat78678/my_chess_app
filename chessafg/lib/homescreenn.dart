import 'package:chessafg/admin_screen.dart';
import 'package:chessafg/news_screen.dart';
import 'package:flutter/material.dart';

class HomeScreenn extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsScreen()),
                );
              },
              child: Text('View News'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminScreen()),
                );
              },
              child: Text('Admin - Post News'),
            ),
          ],
        ),
      ),
    );
  }
}