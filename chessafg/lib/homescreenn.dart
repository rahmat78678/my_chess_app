import 'package:chessafg/news_screen.dart';
import 'package:chessafg/provider/infomation/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'admin_screen.dart';  // Ensure this path is correct

class HomeScreenn extends StatefulWidget {
  @override
  _HomeScreennState createState() => _HomeScreennState();
}

class _HomeScreennState extends State<HomeScreenn> {
  final TextEditingController _passwordController = TextEditingController();

  void _showPasswordDialog(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context,listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(themeProvider.language == 'English'
              ? 'Admin Password'
              : themeProvider.language == 'فارسی'
                  ? "رمز عبور مدیریت"
                  : themeProvider.language == 'پشتو'
                  ? 'مدیریت پاسورډ'
                  : themeProvider.language == 'German'
                      ?'Administrator-Passwort'
                      : 'Admin Password', ),
          content: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(hintText: themeProvider.language == 'English'
              ? "Enter admin password"
              : themeProvider.language == 'فارسی'
                  ?"رمز عبور مدیریت را وارد کنید"
                  : themeProvider.language == 'پشتو'
                  ? "د مدیریت پاسورډ دننه کړئ"
                  : themeProvider.language == 'German'
                      ? 'Einstellungen'
                      :"Enter admin password", 
            ),
          ),
          actions: [
            TextButton(
              child: Text(themeProvider.language == 'English'
              ? 'Cancel'
              : themeProvider.language == 'فارسی'
                  ? 'لغو '
                  : themeProvider.language == 'پشتو'
                  ? 'لغوه '
                  : themeProvider.language == 'German'
                      ? 'Stornieren'
                      : 'Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(themeProvider.language == 'English'
              ? 'Yes'
              : themeProvider.language == 'فارسی'
                  ? 'بلی'
                  : themeProvider.language == 'پشتو'
                  ? 'هو'
                  : themeProvider.language == 'German'
                      ? 'Ja'
                      : 'Yes'),
              onPressed: () {
                if (_passwordController.text == 'rahmat!^&*()@@@@') {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AdminScreen()),
                  );
                } else {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(
                      themeProvider.language == 'English'
              ? 'Password is not correct'
              : themeProvider.language == 'فارسی'
                  ? 'رمز عبور صحیح نیست'
                  : themeProvider.language == 'پشتو'
                  ? 'پټنوم سم نه دی'
                  : themeProvider.language == 'German'
                      ? 'Das Passwort ist nicht korrekt'
                      : 'Password is not correct',)),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(themeProvider.language == 'English'
              ? 'Home'
              : themeProvider.language == 'فارسی'
                  ? 'صفحه اصلی'
                  : themeProvider.language == 'پشتو'
                  ? 'کور'
                  : themeProvider.language == 'German'
                      ? 'Heim'
                      : 'Home', 
         ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text(
                themeProvider.language == 'English'
              ? 'Go to Admin Screen'
              : themeProvider.language == 'فارسی'
                  ? 'به صفحه مدیریت بروید'
                  : themeProvider.language == 'پشتو'
                  ? 'د مدیریت سکرین ته لاړ شئ'
                  : themeProvider.language == 'German'
                      ? 'Gehen Sie zum Admin-Bildschirm'
                      : 'Go to Admin Screen', ),
              onPressed: () {
                _showPasswordDialog(context);
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsScreen()),
                );
              },
              child: Text(
                themeProvider.language == 'English'
              ? 'News Screen'
              : themeProvider.language == 'فارسی'
                  ? 'صفحه خبر'
                  : themeProvider.language == 'پشتو'
                  ? 'د خبرونو پرده'
                  : themeProvider.language == 'German'
                      ? 'Nachrichtenbildschirm'
                      : 'News Screen',),
            ),
          ],
        ),
      ),
    );
  }
}
